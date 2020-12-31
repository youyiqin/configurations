#Import-Module posh-git
#Import-Module oh-my-posh
#Set-Theme Paradox
#Set-Theme Material
#set-theme Agnoster
Import-Module PSReadLine
#Install-Module ZLocation -Scope CurrentUser
Set-PSReadlineKeyHandler -Key Tab -Function Complete
# set-theme qwerty
# set-theme robbyrussell
set-theme Operator
set-alias note 'C:\Program Files (x86)\Notepad++\notepad++.exe'
set-alias nginx 'D:\software\nginx\nginx.exe'
set-alias st set-theme
# rust course
set RUSTUP_DIST_SERVER="https://mirrors.tuna.tsinghua.edu.cn/rustup"
# Set encoding
[System.Console]::OutputEncoding = [System.Text.Encoding]::GetEncoding(936);
# function get-svnurl($path)
# {
# 	giveme svnurl $path
# }
# set-alias gs get-svnurl

function gssh() {
	 Start-Job -ScriptBlock { & gcloud beta compute ssh --zone "asia-east2-a" "instance-1" --project "complete-road-273215" }
}

function tssh() {
  ssh root@175.24.67.59
}

function l($port = "0") {
  start "http://808$($port).langlang.com"
  langlang course run
}
function ll() {
  langlang course run
}

set-alias lt l-test
function lo() {
  l-work open
}
function lb() {
  l-work build
}


function lc($name) {
  langlang course create "$($name)$(get-random -min 1 -max 9999)"
}

function cd1() { cd .. }

function cd2() {
  cd ..\..\
}

function cd3() {
  cd ..\..\..\
}

function working () {
  cd D:\W\langlang_course
}

function Set-EgretDirectory () {
  cd D:\W\egret_game
}
set-alias se Set-EgretDirectory

function frm($path) {
  rm -force -Recurse $path
}
# set-alias sed "D:\Chocolatey\bin\sed.exe"
# set-alias awk "D:\Chocolatey\bin\awk.exe"


function bbuild () {
  . $home\pss\auto_build.ps1
}

function get-cookie () {
  $r = tshark -V -Y 'http.request.method=="POST"' -c 6 -i wlan tcp dst port 80 and dst net 121.37.19.147
  
  if ( $r -match "Cookie pair: (.*)" ) {
    $matches[0] -replace 'Cookie pair: ', '' > $home\langlang_build_token.conf
  }
}

function cppwd($filename) {  
  if ($null -eq $filename) {
    Set-Clipboard (Get-Location)
    Write-Host "copy current directory path: " (Get-Location) -ForegroundColor green -BackgroundColor black
  }
  else {
    if ((Get-Item $filename) -is [System.IO.DirectoryInfo]) {
      $result = (get-item $filename).FullName
      Write-Host "copy the directory path: $($result)" -ForegroundColor green -BackgroundColor black
      Set-Clipboard $result
    }
    else {
      Set-Clipboard (Get-ChildItem $filename).FullName
      Write-Host "copy the current file's full path: " (Get-ChildItem $filename).FullName -ForegroundColor green -BackgroundColor black
    }
  }
}

function cpdir() {
  $pwd = get-location
  $pwd -replace ".*\\", "" | Set-Clipboard
}

function gs($path) {
  try {
    Set-Clipboard (svn info $path 2> $null | grep ^URL).Split(" ")[1]
  }
  catch {
    write-host "This directory is not a valid SVN repository." -ForegroundColor red -BackgroundColor black
    return
  }
  write-host "Success: $(get-clipboard)" -ForegroundColor green -BackgroundColor black
}

function mkcd($newDir) {
  if ($null -eq $newDir) {
    Write-Host "You have not added a directory."
  }
  else {
    mkdir $newDir
    Set-Location $newDir
  }
}

set-alias gvim "C:\tools\vim\vim82\gvim.exe"
set-alias vim "C:\tools\neovim\Neovim\bin\nvim.exe"
set-alias ngvim "C:\tools\neovim\Neovim\bin\nvim-qt.exe"
set-alias tshark "C:\Program Files\Wireshark\tshark.exe"

function svnall() {
  svn add . --force
}

function svnci ($content) {
  svn ci -m "$($content)"
}


function svnrmall () {
  svn status | ? { $_ -match '^!\s+(.*)' } | % { svn rm $Matches[1] }
}

function svnmv {
  Param(
    [parameter(position = 0)]
    $source,
    [parameter(position = 1)]
    $target

  )
  Write-Host "mv $($source) to $($target) and rm it with svn." -BackgroundColor black -ForegroundColor green
  Move-Item $source $target
  Write-Host "Delete it:" -BackgroundColor black -ForegroundColor blue
  svn delete $source
  Write-Host "Add new one into repo task." -BackgroundColor black -ForegroundColor blue
  svn add $target
}

# pipinyin：python库，支持内置cli，中文转拼音
# 有一个需求，说不定以后会用到
# 将当前目录下的文件的文件名的中文部分转为拼音
function filename2pinyin ($path) {
  iF ($path) {
    $path = "."
  }
  ls $path | foreach ($_) { mv $_.name ((pypinyin -s NORMAL $_.name) -replace " ", "" ) } 
}

function updateXbuildToken ($token) {
  (get-content $env:temp\config.json) -replace "token:.*$", "token: `"$($token)`","
}

Set-Alias tail "D:\tools\GitHubDesktop\app-2.5.2\resources\app\git\usr\bin\tail.exe"
set-alias ffmpeg "D:\software\ffmpeg\bin\ffmpeg.exe"

# 本地递归解密普通文本文件
function fuckyou-Lock () {
  ls -file -Recurse * | foreach { cat $_.fullname > "$($_.fullname).bak" && rm -Force $_.fullname && mv "$($_.fullname).bak" $_.fullname }
}

# fuck working directory
function clb($path, $level) {
  cd "D:\W\langlang_course\cailiaobao$($path)$($level)"
}
function game() {
  cd "D:\Projects\egret_game"
}

function cdcp() {
  get-clipboard | set-location
}

# 提取视频关键帧
function get-frame($filename) {
  ffmpeg -i $filename -vf select='eq(pict_type\,I)' -vsync 2 -s 1920*1080 -f image2 core-%02d.jpeg
}

function get-firstFrame($file, $name) {
	ffmpeg -i $file -vframes 1 "$($name).png"
}

function svn-init-lb () {
	svnci "init" && lb
}

function lb (){
	l-work build
}

function lo () {
	l-work open
}

function mvd ($src, $dst) {
	mv "C:\Users\44300\Downloads\$($src)" $dst
}
# clear all info
cls