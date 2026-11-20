# Zorich Mathematical Analysis — Solutions

卓里奇《数学分析》习题解答：独立编写、逐步完善的中文数学学习讲义。

An independent, work-in-progress collection of solutions to exercises in
Zorich's *Mathematical Analysis*, written in LaTeX.

## 项目目标与当前进度

目标是系统整理第一册、第二册的习题解答，重视证明的严谨性、记号的一致性和教材式排版。
目前已建立工程框架和第一册第一章第一节的内容入口，**尚无宣称完成的教材章节**。
章节标题均为占位标题，`solutions.tex` 中只有明确标记的原创排版测试。
这些示例不对应原书习题，不能作为原书题目或题号的依据。

原有的 `ahead.md`、`Q1.md`、`Q2.md` 原样保留为学习笔记，目前不参与 PDF 编译。
正式写作前，请先记录所用教材的语言、版本、版次、出版年份及题号约定；目前这些信息待补充。

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
├── Book1/Chapter1/section1/
│   ├── solutions.tex              # 当前可开始写作的位置
│   ├── ahead.md                   # 保留的原有笔记
│   ├── Q1.md
│   └── Q2.md
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

在 PowerShell 中：

```powershell
Set-Location D:\code_by_vscode\projects\Zorich_Analysis
.\scripts\build.ps1
```

脚本从自身位置定位项目根目录，因此也可以从其他目录用完整路径调用。
若本机执行策略阻止运行脚本，可以直接使用下面的 latexmk 命令，无需更改系统策略。

在 Windows、Linux 或 macOS 的项目根目录中均可执行：

```text
latexmk -norc -r latexmkrc main.tex
```

生成文件为 **`build/Zorich_Analysis_Book1.pdf`**，辅助文件和 `.synctex.gz` 同样位于 `build/`。
latexmk 会按需重复编译，直到目录与交叉引用稳定。编译失败时返回非零退出码，
可查看 `build/Zorich_Analysis_Book1.log`。
`-norc -r latexmkrc` 使各入口显式加载同一份项目配置，避免个人全局 latexmk 配置干扰。

缓存清理与重新构建：

```powershell
.\scripts\build.ps1 -Clean    # 清理辅助文件，保留 PDF
.\scripts\build.ps1 -Rebuild  # 强制重新编译
```

`-Clean` 后再次编译会重新生成 SyncTeX 定位文件。需要完整清理时，可在项目根目录运行
`latexmk -norc -r latexmkrc -C main.tex`，这也会移除生成的 PDF。

## VS Code 写作

请通过“打开文件夹”打开 **`Zorich_Analysis` 项目根目录**，以加载本仓库的 `.vscode` 设置。
打开 `section1` 或其上层的大工作区不会自动应用嵌套文件夹内的设置。

- 保存 `.tex` 文件后，LaTeX Workshop 使用项目 recipe 自动构建。
- `Ctrl+Alt+B` 手动构建；`Ctrl+Alt+V` 打开内置 PDF 预览。
- `Ctrl+Alt+J` 从源码定位到 PDF；在内置 PDF 上 `Ctrl+单击` 返回源码。
- `solutions.tex` 和导言区文件顶部有 `% !TeX root = ...`，在子文件中也构建根入口。
- 新增子文件时，按文件所在层级写正确的相对根路径；不要添加 `\documentclass` 或 `\begin{document}`。

引擎、错误处理、输出路径和 SyncTeX 参数由 `latexmkrc` 管理；VS Code 仅调用 latexmk。
设置中的 `outDir` 和 `jobname` 用于告诉预览器去哪里寻找相同的 PDF，未另行指定编译参数。
若将来改输出名，请同步更新它们、脚本中的结果检查及工作流中的 Artifact 路径。
配置可参考 [LaTeX Workshop 编译文档](https://github.com/James-Yu/LaTeX-Workshop/wiki/Compile)
和 [PDF / SyncTeX 文档](https://github.com/James-Yu/LaTeX-Workshop/wiki/View)。

## 题解编写约定

先删除 `solutions.tex` 中 `BEGIN ORIGINAL TYPESETTING TESTS` 到
`END ORIGINAL TYPESETTING TESTS` 的整段测试内容，并更新 `main.tex` 的编写说明及占位标题。
一节的正文都写入该节的 `solutions.tex`，公共配置只放入 `preamble/`。

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

### 数学记号与证明

常用命令：`\R`、`\N`、`\Z`、`\Q`、`\C`、`\eps`、`\abs{x}`、`\norm{x}`、`\set{x}`、
`\inner{x,y}`、`\dd`（微分符号，亦可用 `\dif`）、`\diam`、`\Span`。
括号自动缩放用 `\abs*{...}`，指定大小用 `\norm[\big]{...}`；默认不自动放大。
集合可写作 `\set{x\in\R : x>0}`。保留 LaTeX 既有命令，新增公共符号使用
`\newcommand` 或 `\DeclareMathOperator`，遇重名应检查并调整命名，避免静默改写既有含义。

使用 `\[...\]` 写无需引用的公式，使用 `equation`、`align` 写编号公式；避免 `$$...$$`。
明确变量范围、量词、自然数约定及依赖的结论。引用原书定理时注明教材版本和位置，
引用其他资料时提供来源；检查边界情形，不省略关键论证。

### 扩展章节和第二册

仅在需要时创建对应的 `Chapter2/section1/solutions.tex` 等目录及文件，
在 `main.tex` 中增加对应的 `\chapter`、`\section` 和 `\input{...}` 即可。
不要在每节中重复加载宏包或重定义公共环境。

目前 `main.tex` 只编译第一册。第二册开始编写后，可新建独立的主入口，复用三个导言区文件，
并为其配置独立输出名及构建任务；当前无需提前创建空白入口。
若将两册合编并在第二册重置章号，还需在显示编号及 PDF 锚点中加入册号，以保持全局唯一。

## GitHub Actions 与获取 PDF

`.github/workflows/build-pdf.yml` 在推送至 `main`、向 `main` 发起 pull request，
以及手动运行时触发。工作流使用 Ubuntu 24.04，从 apt 安装 TeX Live、中文包及字体，
执行与本地相同的 latexmk 命令；仅授予 `contents: read` 权限，不需要自建令牌或 Secrets。
检出和上传分别使用 GitHub 官方维护的
[actions/checkout](https://github.com/actions/checkout) 与
[actions/upload-artifact](https://github.com/actions/upload-artifact)。

手动完成首次远程发布时：

1. 将本项目根目录作为 GitHub 仓库根目录，提交源码和配置；不要提交 `build/`。
2. 确保远程分支使用 `main`。当前本地仓库分支为 `master`，如决定采用 `main`，可自行执行
   `git branch -m main` 后配置远程并推送。本次工程搭建不改名分支、不提交、不登录、不推送。
3. 在仓库 **Settings → Actions → General** 中允许 GitHub Actions 及所用官方 Actions；
   组织仓库可能需要管理员放行。无需启用工作流写权限。
4. 到 **Actions → Build PDF** 查看运行日志。fork 的 PR 可能需仓库维护者批准运行。

成功运行后，在该次运行页面的 **Artifacts** 区域下载 `Zorich_Analysis_Book1`，
解压即可获得 `Zorich_Analysis_Book1.pdf`。选择对应最新 `main` 提交的成功运行，
避免把 PR 的预览产物当作主分支版本。Artifact 默认保留 30 天，下载通常需要登录 GitHub。
本地则直接打开 `build/Zorich_Analysis_Book1.pdf`。

PDF 不纳入普通 Git 历史，`figures/` 中作为素材的 PDF 仍可正常跟踪。
目前未配置 GitHub Pages，因此没有稳定的公开 PDF 阅读地址。
以后如需公开长期链接，可单独增加发布到 Release 或 Pages 的流程；Pages 需要仓库设置中选择
GitHub Actions 作为部署来源，并在独立部署任务中配置 `pages: write`、`id-token: write`
及 `github-pages` 环境，不影响当前基础构建。

## 贡献与反馈

欢迎通过 Issue 报告错误，注明教材版本、章、节、题号及具体问题；
通过 PR 提交修订时，请说明证明思路和修订依据，并确认本地可编译。
提交原创证明、必要的题意概述和已获许可的素材，保留出处及许可信息。
每个 PR 尽量围绕一个习题或一组关联修订展开，不提交辅助文件、自动生成 PDF 或编辑器缓存。

## 许可、版权与免责声明

本项目是独立编写的非官方学习资料，不隶属于卓里奇本人及原书出版社，也不代表其立场。
原书名称仅用于识别学习对象；原书及其他第三方内容的权利归各自权利人所有。
仓库不收录原书扫描件、未经授权的完整教材，亦不批量加入未经授权的完整原题文本。
没有题目授权时，优先给出版本、章、节、题号和必要的独立题意概述。

本仓库自行编写且可授权的源码、脚本与原创文稿采用 [MIT License](LICENSE)。
该许可不授予任何原书或其他第三方内容的权利；有单独许可的素材遵循其各自许可。
解答仍在校对中，可能含有错误，应结合教材及独立推理核验。
