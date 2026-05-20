# ==========================================
# 感知起源网站 - 免费上线脚本 (Windows)
# 方法: GitHub + Vercel (免费，无需信用卡)
# ==========================================

Write-Host ""
Write-Host "===== 感知起源 · 免费上线脚本 =====" -ForegroundColor Cyan
Write-Host ""

# 步骤1：检查 git
try {
    $gitVersion = git --version
    Write-Host "[OK] Git 已安装: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "[!] 未检测到 Git，请先安装 Git:" -ForegroundColor Yellow
    Write-Host "    下载: https://git-scm.com/download/win" -ForegroundColor White
    Write-Host "    安装后重新运行此脚本" -ForegroundColor White
    exit 1
}

# 步骤2：检查是否已有远程仓库
$hasRemote = git remote -v 2>$null
if (-not $hasRemote) {
    Write-Host "============================================" -ForegroundColor Magenta
    Write-Host "步骤1: 创建 GitHub 仓库" -ForegroundColor Yellow
    Write-Host "============================================" -ForegroundColor Magenta
    Write-Host ""
    Write-Host "请按以下步骤操作:" -ForegroundColor White
    Write-Host ""
    Write-Host "1. 打开浏览器，登录 https://github.com" -ForegroundColor White
    Write-Host "   (如果没有账号，花2分钟注册一个)" -ForegroundColor White
    Write-Host ""
    Write-Host "2. 点击右上角 '+' → 'New repository'" -ForegroundColor White
    Write-Host ""
    Write-Host "3. Repository name 输入: sensing-origin" -ForegroundColor Green
    Write-Host "   选择 Public（公开，免费）" -ForegroundColor Green
    Write-Host "   不要勾选任何初始化选项" -ForegroundColor Yellow
    Write-Host "   点击 'Create repository'" -ForegroundColor White
    Write-Host ""
    
    $githubUser = Read-Host "请输入你的 GitHub 用户名"
    
    if ($githubUser) {
        Write-Host ""
        Write-Host "正在初始化本地仓库..." -ForegroundColor Cyan
        
        # 初始化 git
        git init
        git add .
        git commit -m "初始版本 - 感知起源官方网站"
        
        # 设置远程仓库
        $repoUrl = "https://github.com/$githubUser/sensing-origin.git"
        git remote add origin $repoUrl
        
        Write-Host ""
        Write-Host "============================================" -ForegroundColor Magenta
        Write-Host "步骤2: 推送到 GitHub" -ForegroundColor Yellow
        Write-Host "============================================" -ForegroundColor Magenta
        Write-Host ""
        Write-Host "执行以下命令推送代码（会弹出 GitHub 登录窗口）:" -ForegroundColor White
        Write-Host ""
        Write-Host "   git push -u origin main" -ForegroundColor Green
        Write-Host ""
        
        $pushNow = Read-Host "是否现在推送? (y/n)"
        if ($pushNow -eq 'y') {
            git push -u origin main
            if ($LASTEXITCODE -eq 0) {
                Write-Host ""
                Write-Host "[OK] 代码已成功推送到 GitHub!" -ForegroundColor Green
            } else {
                Write-Host ""
                Write-Host "[!] 推送失败。可能是:" -ForegroundColor Yellow
                Write-Host "   - 仓库名不是 sensing-origin" -ForegroundColor White
                Write-Host "   - 需要先设置 GitHub token" -ForegroundColor White
                Write-Host "   - 可尝试: git push -u origin master" -ForegroundColor White
            }
        }
    }
} else {
    Write-Host "[OK] 已有远程仓库，跳过 GitHub 设置" -ForegroundColor Green
    git add .
    git commit -m "更新网站 $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
    git push
}

# 步骤3：Vercel 部署说明
Write-Host ""
Write-Host "============================================" -ForegroundColor Magenta
Write-Host "步骤3: 部署到 Vercel（免费托管）" -ForegroundColor Yellow
Write-Host "============================================" -ForegroundColor Magenta
Write-Host ""
Write-Host "最后一步，部署到 Vercel:" -ForegroundColor White
Write-Host ""
Write-Host "1. 打开浏览器访问:" -ForegroundColor White
Write-Host "   https://vercel.com/new" -ForegroundColor Green
Write-Host ""
Write-Host "2. 点击 'Continue with GitHub'，用 GitHub 登录" -ForegroundColor White
Write-Host "   (授权 Vercel 访问你的仓库)" -ForegroundColor White
Write-Host ""
Write-Host "3. 在 'Import Git Repository' 页面:" -ForegroundColor White
Write-Host "   - 找到 'sensing-origin' 仓库" -ForegroundColor Green
Write-Host "   - 点击 'Import'" -ForegroundColor Green
Write-Host ""
Write-Host "4. 保持默认设置，直接点击 'Deploy'" -ForegroundColor White
Write-Host ""
Write-Host "5. 等待约30秒，看到 'Congratulations!' 即部署成功!" -ForegroundColor Green
Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "你的网站地址将是:" -ForegroundColor Cyan
Write-Host "https://sensing-origin.vercel.app" -ForegroundColor White
Write-Host ""
Write-Host "之后每次更新:" -ForegroundColor Cyan
Write-Host "   git add ." -ForegroundColor White
Write-Host "   git commit -m '更新说明'" -ForegroundColor White
Write-Host "   git push" -ForegroundColor White
Write-Host "Vercel 会自动重新部署（免费）" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Cyan

Read-Host "`n按回车键退出"
