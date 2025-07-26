#!/usr/bin/env python3
"""
Fedora Font Installation Script
Automates the installation of fonts using various methods available in Fedora.
"""

import os
import sys
import subprocess
import shutil
from pathlib import Path
import argparse
import tempfile
import zipfile
import tarfile
from urllib.request import urlretrieve
from urllib.parse import urlparse


class FedoraFontInstaller:
    def __init__(self):
        self.user_fonts_dir = Path.home() / ".local/share/fonts"
        self.system_fonts_dir = Path("/usr/share/fonts")
        self.font_cache_cmd = ["fc-cache", "-f", "-v"]

    def run_command(self, cmd, check=True, shell=False):
        """Run a shell command and return the result."""
        try:
            if shell:
                result = subprocess.run(
                    cmd, shell=True, capture_output=True, text=True, check=check
                )
            else:
                result = subprocess.run(
                    cmd, capture_output=True, text=True, check=check
                )
            return result
        except subprocess.CalledProcessError as e:
            print(
                f"Error running command: {' '.join(cmd) if isinstance(cmd, list) else cmd}"
            )
            print(f"Error: {e.stderr}")
            return None

    def install_packaged_fonts(self, search_term=None):
        """Install fonts using DNF package manager."""
        print("🔍 Searching for available font packages...")

        if search_term:
            search_cmd = ["dnf", "search", f"*{search_term}*font*"]
        else:
            search_cmd = ["dnf", "search", "*font*"]

        result = self.run_command(search_cmd, check=False)
        if result and result.stdout:
            print("Available font packages:")
            print(result.stdout)

            # Ask user which packages to install
            packages = input(
                "Enter package names to install (space-separated): "
            ).strip()
            if packages:
                install_cmd = ["sudo", "dnf", "install"] + packages.split()
                print(f"Installing packages: {packages}")
                subprocess.run(install_cmd)
                self.update_font_cache()
        else:
            print("No font packages found or error in search.")

    def install_system_fonts(self, font_paths, system=False):
        """Install fonts to system or user directory."""
        if system:
            target_dir = self.system_fonts_dir
            print(f"📁 Installing fonts to system directory: {target_dir}")
        else:
            target_dir = self.user_fonts_dir
            print(f"📁 Installing fonts to user directory: {target_dir}")

        # Create target directory if it doesn't exist
        target_dir.mkdir(parents=True, exist_ok=True)

        installed_fonts = []
        for font_path in font_paths:
            font_file = Path(font_path)
            if font_file.exists() and font_file.suffix.lower() in [
                ".ttf",
                ".otf",
                ".woff",
                ".woff2",
            ]:
                try:
                    if system:
                        # Use sudo for system installation
                        subprocess.run(
                            ["sudo", "cp", str(font_file), str(target_dir)], check=True
                        )
                    else:
                        shutil.copy2(font_file, target_dir)
                    installed_fonts.append(font_file.name)
                    print(f"✅ Installed: {font_file.name}")
                except Exception as e:
                    print(f"❌ Failed to install {font_file.name}: {e}")
            else:
                print(f"⚠️  Invalid font file: {font_path}")

        if installed_fonts:
            print(f"Successfully installed {len(installed_fonts)} fonts.")
            self.update_font_cache()

        return installed_fonts

    def download_and_install_font(self, url, system=False):
        """Download font from URL and install it."""
        print(f"📥 Downloading font from: {url}")

        try:
            # Create temporary directory
            with tempfile.TemporaryDirectory() as temp_dir:
                temp_path = Path(temp_dir)

                # Parse URL to get filename
                parsed_url = urlparse(url)
                filename = os.path.basename(parsed_url.path)
                if not filename:
                    filename = "downloaded_font"

                download_path = temp_path / filename

                # Download file
                urlretrieve(url, download_path)
                print(f"📦 Downloaded: {filename}")

                # Extract if it's an archive
                font_files = []
                if filename.endswith(".zip"):
                    with zipfile.ZipFile(download_path, "r") as zip_ref:
                        zip_ref.extractall(temp_path)
                        font_files = list(temp_path.glob("**/*.ttf")) + list(
                            temp_path.glob("**/*.otf")
                        )
                elif filename.endswith((".tar.gz", ".tar.bz2", ".tar.xz")):
                    with tarfile.open(download_path, "r:*") as tar_ref:
                        tar_ref.extractall(temp_path)
                        font_files = list(temp_path.glob("**/*.ttf")) + list(
                            temp_path.glob("**/*.otf")
                        )
                else:
                    # Assume it's a font file
                    font_files = [download_path]

                if font_files:
                    return self.install_system_fonts(
                        [str(f) for f in font_files], system=system
                    )
                else:
                    print("❌ No font files found in downloaded archive.")
                    return []

        except Exception as e:
            print(f"❌ Error downloading/installing font: {e}")
            return []

    def install_google_fonts(self, font_name):
        """Install fonts from Google Fonts (requires git)."""
        print(f"🔍 Installing Google Font: {font_name}")

        # Check if git is available
        if not shutil.which("git"):
            print(
                "❌ Git is not installed. Please install git first: sudo dnf install git"
            )
            return []

        try:
            with tempfile.TemporaryDirectory() as temp_dir:
                temp_path = Path(temp_dir)

                # Clone Google Fonts repository (shallow clone for speed)
                print("📥 Cloning Google Fonts repository...")
                clone_cmd = [
                    "git",
                    "clone",
                    "--depth",
                    "1",
                    "--filter=blob:none",
                    "--sparse",
                    "https://github.com/google/fonts.git",
                    str(temp_path / "fonts"),
                ]

                result = self.run_command(clone_cmd)
                if not result:
                    return []

                fonts_dir = temp_path / "fonts"

                # Search for the font
                font_dirs = list(fonts_dir.glob(f"**/*{font_name.lower()}*"))
                if not font_dirs:
                    print(f"❌ Font '{font_name}' not found in Google Fonts.")
                    return []

                # Find font files
                font_files = []
                for font_dir in font_dirs:
                    font_files.extend(font_dir.glob("*.ttf"))
                    font_files.extend(font_dir.glob("*.otf"))

                if font_files:
                    return self.install_system_fonts([str(f) for f in font_files])
                else:
                    print(f"❌ No font files found for '{font_name}'.")
                    return []

        except Exception as e:
            print(f"❌ Error installing Google Font: {e}")
            return []

    def update_font_cache(self):
        """Update the font cache."""
        print("🔄 Updating font cache...")
        result = self.run_command(self.font_cache_cmd)
        if result:
            print("✅ Font cache updated successfully.")
        else:
            print("❌ Failed to update font cache.")

    def list_installed_fonts(self):
        """List all installed fonts."""
        print("📋 Listing installed fonts...")
        result = self.run_command(["fc-list"])
        if result:
            fonts = result.stdout.strip().split("\n")
            print(f"Found {len(fonts)} installed fonts:")
            for font in sorted(fonts)[:20]:  # Show first 20
                print(f"  {font}")
            if len(fonts) > 20:
                print(f"  ... and {len(fonts) - 20} more fonts")
        else:
            print("❌ Failed to list fonts.")

    def search_fonts(self, pattern):
        """Search for fonts matching a pattern."""
        print(f"🔍 Searching for fonts matching: {pattern}")
        result = self.run_command(["fc-list", f":{pattern}"])
        if result and result.stdout.strip():
            fonts = result.stdout.strip().split("\n")
            print(f"Found {len(fonts)} matching fonts:")
            for font in fonts:
                print(f"  {font}")
        else:
            print("No matching fonts found.")

    def install_nerd_fonts(self, font_name="JetBrainsMono"):
        """Install Nerd Fonts."""
        print(f"🤓 Installing Nerd Font: {font_name}")

        # Nerd Fonts GitHub releases
        base_url = "https://github.com/ryanoasis/nerd-fonts/releases/latest/download"
        font_url = f"{base_url}/{font_name}.zip"

        return self.download_and_install_font(font_url)


def main():
    parser = argparse.ArgumentParser(description="Fedora Font Installation Script")
    parser.add_argument(
        "--search-packages", metavar="TERM", help="Search for font packages"
    )
    parser.add_argument(
        "--install-packages",
        nargs="+",
        metavar="PACKAGE",
        help="Install font packages via DNF",
    )
    parser.add_argument(
        "--install-files", nargs="+", metavar="FILE", help="Install font files"
    )
    parser.add_argument(
        "--install-url", metavar="URL", help="Download and install font from URL"
    )
    parser.add_argument(
        "--google-font", metavar="NAME", help="Install font from Google Fonts"
    )
    parser.add_argument(
        "--nerd-font",
        metavar="NAME",
        nargs="?",
        const="JetBrainsMono",
        help="Install Nerd Font (default: JetBrainsMono)",
    )
    parser.add_argument(
        "--system",
        action="store_true",
        help="Install to system directory (requires sudo)",
    )
    parser.add_argument("--list", action="store_true", help="List installed fonts")
    parser.add_argument("--search", metavar="PATTERN", help="Search installed fonts")
    parser.add_argument("--update-cache", action="store_true", help="Update font cache")

    args = parser.parse_args()

    installer = FedoraFontInstaller()

    if args.search_packages:
        installer.install_packaged_fonts(args.search_packages)
    elif args.install_packages:
        install_cmd = ["sudo", "dnf", "install"] + args.install_packages
        subprocess.run(install_cmd)
        installer.update_font_cache()
    elif args.install_files:
        installer.install_system_fonts(args.install_files, system=args.system)
    elif args.install_url:
        installer.download_and_install_font(args.install_url, system=args.system)
    elif args.google_font:
        installer.install_google_fonts(args.google_font)
    elif args.nerd_font:
        installer.install_nerd_fonts(args.nerd_font)
    elif args.list:
        installer.list_installed_fonts()
    elif args.search:
        installer.search_fonts(args.search)
    elif args.update_cache:
        installer.update_font_cache()
    else:
        # Interactive mode
        print("🎨 Fedora Font Installer")
        print("=" * 30)
        print("1. Search and install packaged fonts")
        print("2. Install font files from local path")
        print("3. Download and install font from URL")
        print("4. Install Google Font")
        print("5. Install Nerd Font")
        print("6. List installed fonts")
        print("7. Search installed fonts")
        print("8. Update font cache")

        choice = input("\nSelect an option (1-8): ").strip()

        if choice == "1":
            search_term = input("Enter search term (or press Enter for all): ").strip()
            installer.install_packaged_fonts(search_term or None)
        elif choice == "2":
            paths = input("Enter font file paths (space-separated): ").strip().split()
            system = (
                input("Install to system directory? (y/N): ").lower().startswith("y")
            )
            installer.install_system_fonts(paths, system=system)
        elif choice == "3":
            url = input("Enter font URL: ").strip()
            system = (
                input("Install to system directory? (y/N): ").lower().startswith("y")
            )
            installer.download_and_install_font(url, system=system)
        elif choice == "4":
            font_name = input("Enter Google Font name: ").strip()
            installer.install_google_fonts(font_name)
        elif choice == "5":
            font_name = input("Enter Nerd Font name (default: JetBrainsMono): ").strip()
            installer.install_nerd_fonts(font_name or "JetBrainsMono")
        elif choice == "6":
            installer.list_installed_fonts()
        elif choice == "7":
            pattern = input("Enter search pattern: ").strip()
            installer.search_fonts(pattern)
        elif choice == "8":
            installer.update_font_cache()
        else:
            print("Invalid option selected.")


if __name__ == "__main__":
    main()
