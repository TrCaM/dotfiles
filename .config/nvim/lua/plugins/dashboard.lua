return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      -- your dashboard configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      -- {
      sections = (function()
        math.randomseed(os.time())
        local pokemons = {
          "pikachu",
          "snorlax",
          "bulbasaur",
          "squirtle",
          "blastoise",
          "gengar",
          "psyduck",
          "dragonite",
        }
        local small_pokemons = {
          pikachu = true,
          bulbasaur = true,
          squirtle = true,
        }
        local chosen_pokemon = pokemons[math.random(#pokemons)]
        local height = small_pokemons[chosen_pokemon] and 15 or 20

        return {
          {
            section = "terminal",
            cmd = "/usr/local/bin/pokemon-colorscripts -n " .. chosen_pokemon .. " --no-title; sleep .1",
            random = 8,
            height = height,
            indent = 3,
          },
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup" },
        }
      end)(),
    },
  },
}
