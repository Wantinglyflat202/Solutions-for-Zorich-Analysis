# Zorich Mathematical Analysis — Solutions

卓里奇《数学分析》习题解答
An independent, work-in-progress collection of solutions to exercises in
Zorich's *Mathematical Analysis*, written in LaTeX.


## 目录结构

```text
Zorich_Analysis/
├── main.tex                       # 当前为第一册总入口
├── latexmkrc                      # 唯一的编译参数来源
├── README.md
├── LICENSE
├── .gitignore
├── preamble/
│   ├── packages.tex               # 宏包、页面、字体、超链接
│   ├── commands.tex               # 数学记号
│   └── environments.tex           # 习题、解答及定理环境
├── Book1/Chapter1/section1/       # 第一册第一章第一节的解答，之后同
│               
├── Book2/.gitkeep                 # 尚未编写
├── figures/.gitkeep
├── scripts/build.ps1
├── .vscode/
│   ├── settings.json
│   └── extensions.json
├── .github/workflows/build-pdf.yml
└── build/                         # 构建时生成，Git 忽略
```

## 本地编译

需要 TeX Live 或 MiKTeX、XeLaTeX、latexmk 及其 Perl 运行环境。VS Code 用户另需安装
LaTeX Workshop（`James-Yu.latex-workshop`）。建议使用较完整的 TeX 发行版；工程不会自动安装软件。
TeX Live 通常已提供 Perl；MiKTeX 用户需确保 Perl 和 latexmk 可在终端中运行。

依赖包括 `ctex`、`xeCJK`、Fandol 字体、`geometry`、`lmodern`、AMS 宏包、
`mathtools`、`graphicx`、`enumitem`、`microtype`、`hyperref`、`bookmark`。
中文明确使用 TeX 发行版提供的 Fandol 字体，西文及数学使用 Latin Modern，不依赖 Windows 系统字体。
若 MiKTeX 缺少宏包，请通过 MiKTeX Console 安装相应包。

### 习题编号和引用

```latex
\begin{exercise}[7]  % 手动指定本节原书题号，显示为 1.1.7
\label{ex:b1-c1-s1-q7}
在此写题意的必要概述或独立表述。
\end{exercise}
\begin{solution}
在此写严格解答。
\end{solution}

\begin{idea}
在此解释关键思路。
\end{idea}
\begin{alternative}
在此写其他证明；也可在环境内部使用 proof。
\end{alternative}
\begin{generalization}
在此讨论适用范围或推广。
\end{generalization}
```

`exercise` 的可选参数表示**本节内的显示题号**，不是定理环境的副标题。
也支持 `[7(a)]` 等文字编号；不要传入完整的 `1.1.7`，因为章、节前缀会自动添加。
省略参数时按本节自动序号显示 `1.1.1`、`1.1.2` 等。
**手动编号不消耗自动序号**；正式教材题解建议一节内统一使用手动编号，避免混用造成显示题号重复。
必要时用 `\setcounter{exercise}{7}` 让下一个自动题号从 8 开始。
所有题目都有独立超链接锚点；作者仍须保证同节显示题号和全局标签不重复。
手动题号不一定是阿拉伯数字，不要依赖自动数字范围引用。

定理、引理、命题、推论、定义、例子、注记共享一套按节重置的编号，如 `1.1.1`、`1.1.2`；
习题及公式分别独立按节编号。可用环境为
`exercise`、`solution`、`theorem`、`lemma`、`proposition`、`corollary`、
`definition`、`example`、`remark`、`proof`。
`solution` 和 `proof` 均以证毕符号结束；若以陈列公式结束，可在公式中使用 `\qedhere`。

标签使用带册、章、节信息的前缀：`ex:`、`thm:`、`lem:`、`def:`、`eq:`、`sec:`、`chap:`。
将 `\label` 紧接在环境开始或相应的章节命令后；公式标签放入编号公式环境中。
使用 `习题~\ref{ex:b1-c1-s1-q7}`、`定理~\ref{thm:...}`、`式~\eqref{eq:...}`，
不要手写引用的数字。标签在整份主文档中全局可用，支持跨节、跨章引用。

## 许可、版权与免责声明

本项目是独立编写的非官方学习资料，不隶属于卓里奇本人及原书出版社，也不代表其立场。
原书名称仅用于识别学习对象；原书及其他第三方内容的权利归各自权利人所有。
仓库不收录原书扫描件、未经授权的完整教材，亦不批量加入未经授权的完整原题文本。
没有题目授权时，优先给出版本、章、节、题号和必要的独立题意概述。

本仓库自行编写且可授权的源码、脚本与原创文稿采用 [MIT License](LICENSE)。
该许可不授予任何原书或其他第三方内容的权利；有单独许可的素材遵循其各自许可。
解答仍在校对中，可能含有错误，应结合教材及独立推理核验。
