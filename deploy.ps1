# ==========================================
# 感知起源网站 - 自动部署脚本 (Windows)
# 方法: GitHub + Vercel (免费，无需信用卡)
# ==========================================

Write-Host ""
Write-Host "===== 感知起源 · 自动部署脚本 =====" -ForegroundColor Cyan
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

# 自动提交并推送
    Write-Host "============================================" -ForegroundColor Magenta
Write-Host "正在自动部署..." -ForegroundColor Yellow
    Write-Host "============================================" -ForegroundColor Magenta
        git add .
$commitMsg = "更新网站 $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
git commit -m "$commitMsg"
    git push

if ($LASTEXITCODE -eq 0) {
Write-Host ""
    Write-Host "[OK] 代码已成功推送到 GitHub!" -ForegroundColor Green
Write-Host ""
    Write-Host "Vercel 会自动检测更新并部署（约1-2分钟）" -ForegroundColor Cyan
} else {
Write-Host ""
    Write-Host "[!] 推送失败。可能原因:" -ForegroundColor Yellow
    Write-Host "   1. 尚未关联远程仓库 → 先手动执行:" -ForegroundColor White
    Write-Host "      git remote add origin https://github.com/你的用户名/sensing-origin.git" -ForegroundColor White
    Write-Host "   2. 需要登录 → 使用 GitHub CLI 或 Personal Access Token" -ForegroundColor White
}

# Vercel 部署说明
Write-Host ""
Write-Host "============================================" -ForegroundColor Magenta
Write-Host "部署到 Vercel（解决微信/QQ浏览器打不开的问题）" -ForegroundColor Yellow
Write-Host "============================================" -ForegroundColor Magenta
Write-Host ""
Write-Host "【重要】GitHub Pages 在微信/QQ/夸克中会被屏蔽！" -ForegroundColor Red
Write-Host "解决方案：使用 Vercel 免费托管（国内可访问）" -ForegroundColor Green
Write-Host ""
Write-Host "操作步骤：" -ForegroundColor White
Write-Host "1. 打开 https://vercel.com/new" -ForegroundColor Green
Write-Host "2. 用 GitHub 账号登录" -ForegroundColor White
Write-Host "3. 导入 'sensing-origin' 仓库" -ForegroundColor White
Write-Host "4. 点击 'Deploy' 部署" -ForegroundColor Green
Write-Host "5. 部署成功后，你的网站地址为：" -ForegroundColor Cyan
Write-Host "   https://sensing-origin.vercel.app" -ForegroundColor White
Write-Host ""
Write-Host "之后每次运行此脚本推送代码，Vercel 会自动重新部署！" -ForegroundColor Cyan
Read-Host "`n按回车键退出"

