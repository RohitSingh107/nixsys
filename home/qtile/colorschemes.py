
from defaults import colorscheme, home
# import yaml
#
# with open(home + '/.cache/wal/colors.yml', 'r') as f:
#     pywal_colors = yaml.safe_load(f)

colorschemes = {
    "default": [["#ff5555", "#ff5555"],  # 0
                ["#ffffff", "#ffffff"],  # 1
                ["#ffd47e", "#ffd47e"],  # 2
                ["#62FF00", "#62FF00"],  # 3
                ["#c40234", "#c40234"],  # 4
                ["#6790eb", "#6790eb"],  # 5
                ["#282c34", "#282c34"],  # 6
                ["#212121", "#212121"],  # 7
                ["#e75480", "#e75480"],  # 8
                ["#2aa899", "#2aa899"],  # 9
                ["#abb2bf", "#abb2bf"],  # 10
                ["#56b6c2", "#56b6c2"],  # 11
                ["#b48ead", "#b48ead"],  # 12
                ["#ff79c6", "#ff79c6"],  # 13
                ["#e06c75", "#e06c75"],  # 14
                ["#ffb86c", "#ffb86c"]], # 15

    # "pywal" : [[c, c] for c in pywal_colors["colors"].values()],
}

def init_colors(colorscheme="default"):
    return colorschemes[colorscheme]


colors = init_colors(colorscheme)
