{ config, ... }:
{
  config = {
    programs.jujutsu.settings = {
      user = {
        email = "harshalsawant" + ".dev" + "@gmail.com";
        name = "Harshal" + "Sawant";
      };
    };
  };
}
