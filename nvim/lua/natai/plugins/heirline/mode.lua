local icon = require("natai.icons").mode
local utils = require("heirline.utils")
local indicator = { -- see :help mode(1)
  n = string.format("%s  ", icon.n), --[[                   x : ノーマル ]]
  no = string.format("%s%s ", icon.n, icon.o), --[[        󰇘 x : オペレータ待機 ]]
  nov = string.format("%s%s ", icon.n, icon.o), --[[       󰇘 x : オペレータ待機（強制文字単位） ]]
  noV = string.format("%s%s ", icon.n, icon.o), --[[       󰇘 x : オペレータ待機（強制行単位） ]]
  ["no"] = string.format("%s%s ", icon.n, icon.o), --[[  󰇘 x : オペレータ待機（強制ブロック単位） ]]
  niI = string.format("%s%s ", icon.i, icon.n), --[[         x : Insert-mode で i_CTRL-O を使用したノーマル ]]
  niR = string.format("%s %s ", icon.R, icon.n), --[[       󰉼 x : Replace-mode で i_CTRL-O を使用したノーマル ]]
  niV = string.format("%s %s ", icon.R, icon.n), --[[       󰉼 x : Virtual-Replace-mode で i_CTRL-O を使用したノーマル ]]
  nt = string.format("%s %s ", icon.t, icon.n), --[[           x : 端末ノーマル ]]

  v = string.format("%s  ", icon.v), --[[               󰦨   x : 文字単位ビジュアル ]]
  vs = string.format("%s  ", icon.v), --[[              󰦨   x : 選択モードで v_CTRL-O を利用した時の文字単位ビジュアル ]]
  V = string.format("%s ", icon.V), --[[                   x : 行単位ビジュアル ]]
  Vs = string.format("%s ", icon.V), --[[                  x : 選択モードで v_CTRL-O を利用した時の行単位ビジュアル ]]
  [""] = string.format("%s  ", icon["^V"]), --[[          󰿦   x : 矩形ビジュアル ]]
  ["s"] = string.format("%s  ", icon["^V"]), --[[         󰿦   x : 選択モードで v_CTRL-O を利用した時の矩形ビジュアル ]]

  s = string.format("%s  ", icon.s), --[[                   x : 文字単位選択 ]]
  S = string.format("%s  ", icon.s), --[[                   x : 行単位選択 ]]
  [""] = string.format("%s  ", icon.s), --[[              x : 矩形選択 ]]

  i = string.format("%s  ", icon.i), --[[                   x : 挿入 ]]
  ic = string.format("%s%s ", icon.i, icon.o), --[[        󰇘 x : 挿入モード補完 ]]
  ix = string.format("%s%s ", icon.i, icon.o), --[[        󰇘 x : 挿入モード i_CTRL-X 補完 ]]

  R = string.format("%s   ", icon.R), --[[               󰉼   x : 置換 ]]
  Rc = string.format("%s %s ", icon.R, icon.o), --[[      󰉼 󰇘 x : 置換モード補完 compl-generic ]]
  Rv = string.format("%s   ", icon.R), --[[              󰉼   x : 仮想置換 gR ]]
  Rvc = string.format("%s %s ", icon.R, icon.o), --[[     󰉼 󰇘 x : 補完での仮想置換モード compl-generic ]]
  Rvx = string.format("%s %s ", icon.R, icon.o), --[[     󰉼 󰇘 x : i_CTRL-X 補完での仮想置換モード ]]

  c = string.format("%s  ", icon.c), --[[                   x : コマンドライン編集 ]]
  cv = string.format("%s  ", icon.c), --[[                  x : Vim Ex モード gO ]]
  ce = string.format("%s  ", icon.c), --[[                  x : ノーマル Ex モード Q ]]

  r = string.format("%s ", icon.r), --[[                   x : 未使用（StatusLineが表示されない）; Hit-Enter プロンプト ]]
  rm = string.format("%s ", icon.r), --[[                  x : 未使用（StatusLineが表示されない）; -- more -- プロンプト ]]
  ["r?"] = string.format("%s ", icon["?"]), --[[              x : 未使用（StatusLineが表示されない）; ある種の :conrifm 問い合わせ ]]

  t = string.format("%s  ", icon.t), --[[                   x : 端末モード ]]
  ["!"] = string.format("%s   ", icon["!"]), --[[           󰜎   x : 未使用（StatusLineが表示されない）; シェルまたは外部コマンド実行中 ]]
}

local mode_colors = {
  n = "cyan",
  i = "yellow",
  v = "red",
  V = "red",
  ["\22"] = "red",
  c = "yellow",
  s = "red",
  S = "red",
  ["\19"] = "red",
  R = "orange",
  r = "orange",
  ["!"] = "red",
  t = "purple",
}

return {
  hl = function()
    local mode = vim.fn.mode(1):sub(1, 1)
    return { fg = mode_colors[mode] }
  end,
  {
    provider = function()
      return indicator[vim.fn.mode(1)]
    end,
  },
}
