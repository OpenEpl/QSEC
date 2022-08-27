***Only Chinese document is available.***

# Quick And Simple EC

## 编译
### 准备环境
1. [安装 .NET 桌面运行时 3.1](https://dotnet.microsoft.com/zh-cn/download/dotnet/3.1) 
2. 确保 Windows 的 PowerShell 组件正常可用，且安全策略允许运行本地 *.ps1 文件
3. 安装 `ninja` & `eplc` & `TextECode` & `EAutoBuild` & `node` & `npm` 并配置环境变量（或执行别名）
4. 安装代码生成器 `gencode` 的 NPM 依赖（PowerShell命令行：`cd gencode ; npm install ; cd ..`）

### 检验环境
在终端（推荐使用 [Windows Terminal](https://github.com/microsoft/terminal)）执行以下命令，应当均不报错：
```powershell
ninja --version
eplc --help
TextECode --version
EAutoBuild --version
node --version
npm --version
```

### 构建项目
- 运行 `Task_Clean.ps1` 清理已编译文件
- 运行 `Task_Build.ps1` 编译全部项目
- 运行 `Task_Release.ps1` 生成用于发布的 zip 包

## 交流
一般的 bug 反馈 与 feature 请求，请用 GitHub 的 Issues 模块反馈  
如果您希望对本项目做出贡献，请使用标准 GitHub 工作流：Fork + Pull request  
进一步的快速讨论：请加入 QQ 群 `605310933` 或 QQ 频道 `e81tgd8w3m` *（注意不要在群中反馈 bug，这很可能导致反馈没有被记录。聊天消息较 Issues 模块比较混乱）*  

## 许可
本项目使用 [MIT License](./LICENSE.txt) 许可证