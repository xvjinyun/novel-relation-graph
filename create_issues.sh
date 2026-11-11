#!/bin/bash
# 批量创建 20 个 Issue 到小组仓库
#
# 使用前准备（按顺序）：
#   1. 安装 GitHub CLI：https://cli.github.com/   （Windows 也可 winget install GitHub.cli）
#   2. 登录：gh auth login   → 选 GitHub.com → HTTPS → 浏览器授权
#   3. 先把另外三人加为仓库 Collaborator（Settings → Collaborators → Add people）
#   4. 先在 GitHub 上建好 Milestone：v0.1.0、v0.2.0
#   5. 先在 GitHub 上建好 Labels（见下方清单）
#   6. USER_B/C/D 若暂不知道用户名，留空即可 —— 脚本会自动跳过 Assignee，
#      20 个 Issue 照样建好，之后再在网页上手动指派。
#
# 运行：cd 仓库根目录 && bash create_issues.sh
# Windows PowerShell 可用：bash ./create_issues.sh（需 Git Bash）

set -e

REPO="xvjinyun/novel-relation-graph"

USER_A="xvjinyun"   # 许锦芸（组长）：数据采集层，#1—#5
USER_B=""           # 王浩然：文本分析层，#6—#10   ← 待填 GitHub 用户名
USER_C=""           # 杨凯杰：服务与存储层，#11—#15 ← 待填 GitHub 用户名
USER_D=""           # 张顺凯：展示与 AI 层，#16—#20 ← 待填 GitHub 用户名

# 需要预先创建的 Labels：
# crawler nlp backend frontend ai ci parser P0 P1 P2 bug enhancement documentation

create() {
  local no=$1 title=$2 who=$3 labels=$4 ms=$5
  local body="issues/issue-$(printf '%02d' "$no").md"

  echo "创建 Issue #${no}: ${title}"

  local args=(
    --repo "$REPO"
    --title "[FEATURE] ${title}"
    --body-file "$body"
    --milestone "$ms"
  )

  # labels 用逗号分隔时逐个添加，避免 GitHub 把 "crawler,P0" 当成一个标签
  IFS=',' read -ra arr <<< "$labels"
  for l in "${arr[@]}"; do
    args+=(--label "$l")
  done

  # 用户名未填（或仍是占位值）时不传 --assignee，避免创建失败
  if [[ -n "$who" && "$who" != github_user_* ]]; then
    args+=(--assignee "$who")
  fi

  gh issue create "${args[@]}"
}

create 1  "实现 robots 校验与请求限速器"          "$USER_A" "crawler,P0"     "v0.1.0"
create 2  "实现正文抽取与清洗管道"                "$USER_A" "crawler,P0"     "v0.1.0"
create 3  "实现多源站点采集器"                    "$USER_A" "crawler,P0"     "v0.1.0"
create 4  "实现增量抓取与 URL 去重"               "$USER_A" "crawler,P0"     "v0.1.0"
create 5  "实现章回标题识别与章节切分"            "$USER_A" "parser,P1"      "v0.1.0"
create 6  "接入分词与词性标注服务"                "$USER_B" "nlp,P0"         "v0.1.0"
create 7  "实现人物实体识别与频次统计"            "$USER_B" "nlp,P0"         "v0.1.0"
create 8  "实现别名词典与归一处理"                "$USER_B" "nlp,P0"         "v0.1.0"
create 9  "实现人物共现关系抽取算法"              "$USER_B" "nlp,P0"         "v0.1.0"
create 10 "实现章节情感值计算"                    "$USER_B" "nlp,P1"         "v0.2.0"
create 11 "设计数据库模型与迁移脚本"              "$USER_C" "backend,P0"     "v0.1.0"
create 12 "实现作品与章节 REST 接口"              "$USER_C" "backend,P0"     "v0.1.0"
create 13 "实现图谱数据查询与缓存接口"            "$USER_C" "backend,P0"     "v0.2.0"
create 14 "接入 Elasticsearch 全文检索"           "$USER_C" "backend,P1"     "v0.2.0"
create 15 "配置 GitHub Actions 与测试门禁"        "$USER_C" "ci,P0"          "v0.1.0"
create 16 "实现人物关系图谱可视化页面"            "$USER_D" "frontend,P0"    "v0.2.0"
create 17 "实现人物详情与出场曲线页面"            "$USER_D" "frontend,P0"    "v0.2.0"
create 18 "接入大模型实现摘要与人物小传"          "$USER_D" "ai,P1"          "v0.2.0"
create 19 "实现 RAG 问答与溯源展示"               "$USER_D" "ai,P1"          "v0.2.0"
create 20 "实现情感曲线可视化页面"                "$USER_D" "frontend,P1"    "v0.2.0"

echo "全部 20 个 Issue 创建完成"
echo "提示：若 USER_B/C/D 留空，请在 GitHub Issue 列表里手动指派给王浩然、杨凯杰、张顺凯。"
