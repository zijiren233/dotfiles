" 基础设置
set nocompatible
set t_Co=256
if has("termguicolors")
  set termguicolors              " 启用真彩色
endif
set number                     " 显示行号
set relativenumber             " 显示相对行号
set visualbell                 " 禁止响铃
set ruler                      " 显示当前光标位置
set autoread                   " 文件在 Vim 之外修改过，自动重新读入
set autowrite                  " 自动保存
set autochdir                  " 当前目录随着被编辑文件的改变而改变
set nocp                       " 使用 Vim 而非 Vi
set mouse=a                    " 开启鼠标支持
set clipboard=unnamed          " 使用系统剪贴板
set cursorline                 " 突出显示当前行
set guioptions-=T              " 隐藏工具栏
set guioptions-=m              " 隐藏菜单栏
set iskeyword+=_,$,@,%,#,-     " 单词包含特殊符号
set backspace=indent,eol,start " 使回格键正常处理
set whichwrap+=<,>,h,l         " 允许光标键跨越行边界
set showmatch                  " 高亮显示匹配的括号
set matchtime=1                " 匹配括号高亮时间（0.1秒）
set scrolloff=4                " 光标移动时保持4行距离
set confirm                    " 未保存或只读文件时弹出确认
set updatetime=300             " 减少更新延迟
set timeoutlen=500             " 快捷键超时长度

" 搜索设置
set hlsearch                   " 开启搜索结果高亮
set incsearch                  " 边输入边搜索
set ignorecase                 " 忽略大小写
set smartcase                  " 智能大小写搜索

" 缩进设置
set cindent                    " C/C++ 自动缩进
set smartindent                " 智能缩进
set autoindent                 " 自动缩进
filetype indent on             " 根据文件类型进行缩进
set softtabstop=4              " 软制表符宽度
set tabstop=4                  " 制表符宽度
set shiftwidth=4               " 自动缩进宽度

" 文件类型和插件
filetype plugin indent on      " 启动文件类型插件和缩进
syntax on                      " 启用语法高亮

" 文件编码
set encoding=utf-8
set fileencodings=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936

" 语言设置
set langmenu=zh_CN.UTF-8
set helplang=cn

" 多字节支持
if has("multi_byte")
  set fileencodings=utf-8,ucs-bom,cp936,cp1250,big5,euc-jp,euc-kr,latin1
else
  echoerr "Sorry, this version of (g)vim was not compiled with multi_byte"
endif

" gVim 设置
if has("gui_running")
  colorscheme morning
  set guifont=Monaco:h13
  set guioptions=mr             " 只显示菜单和右侧滚动条
endif

" 其他设置
set noswapfile                 " 不生成交换文件
set nobackup                   " 不生成备份文件
set nowritebackup              " 不生成写入备份文件

" 自动命令
autocmd BufNewFile,BufEnter *.txt set ft=confluencewiki

" 命令行补全
set wildmenu                   " 命令行自动补全
set wildmode=longest:full,full " 补全模式
set completeopt=menuone,noselect " 代码补全选项

" 去掉错误提示声音
set noerrorbells
set novisualbell

" 额外优化
set splitbelow                 " 新窗口默认在下方
set splitright                 " 新窗口默认在右侧
set laststatus=0               " 不显示状态栏
set showcmd                    " 显示不完整命令
" set jumpoptions=stack         " 9.0以上才可用
