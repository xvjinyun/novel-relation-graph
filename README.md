# 小说人物关系图谱生成器

> 中文公版小说智能分析平台 —— 把非结构化的小说文本，自动转化为可检索、可量化、可问答的知识。

> 仓库地址：`https://github.com/xvjinyun/novel-relation-graph`（当前建于组长个人账号下，课程组织归属待与授课教师确认）

## 功能特性

- **多源采集**：从开放授权的公版文本站点抓取作品与章节，支持增量抓取与合规限速
- **人物识别**：中文分词、命名实体识别、别名词典归一（「林黛玉」「颦儿」「林姑娘」合并为同一人）
- **关系图谱**：按滑动窗口统计人物共现，自动生成带权重的人物关系网络
- **情感曲线**：按章节计算情感值，呈现全书叙事节奏
- **智能问答**：基于 RAG 的自然语言问答，答案可溯源至原文章节
- **可视化展示**：作品概览、力导向关系图谱、人物详情、全文检索、多作品对比

## 技术栈

Python 3.11 · FastAPI · Scrapy · HanLP · NetworkX · MySQL 8 · Elasticsearch · Vue 3 · Element Plus · ECharts · AntV G6 · Docker Compose · GitHub Actions

## 快速开始

### 环境要求

- Docker >= 24 与 Docker Compose v2（推荐方式）
- 或本地环境：Python >= 3.11、Node.js >= 20、MySQL >= 8.0

### 启动步骤（Docker 方式）

```bash
git clone https://github.com/xvjinyun/novel-relation-graph.git
cd novel-relation-graph
cp .env.example .env          # 填写数据库口令与大模型 API Key
docker compose up -d          # 启动数据库、后端与前端
```

访问 http://localhost:5173

### 启动步骤（本地方式）

```bash
# 后端
cd backend
python -m venv .venv && source .venv/bin/activate   # Windows 用 .venv\Scripts\activate
pip install -r requirements.txt
cp ../.env.example ../.env
uvicorn app.main:app --reload                        # http://localhost:8000/docs

# 前端（新开终端）
cd frontend
npm ci
npm run dev                                          # http://localhost:5173
```

### 采集一部作品

```bash
curl -X POST http://localhost:8000/api/works \
  -H "Content-Type: application/json" \
  -d '{"title":"红楼梦","source_url":"<开放授权站点地址>"}'
```

采集完成后在前端「作品」页面查看分析进度与人物图谱。

## 架构设计

系统采用分层架构：

| 层 | 职责 | 技术选型 |
|---|---|---|
| 采集层 | 抓取、清洗、增量更新 | Scrapy + BeautifulSoup |
| 分析层 | 分词、实体识别、关系抽取、情感计算 | HanLP + jieba + NetworkX |
| 服务层 | 业务逻辑、REST 接口 | FastAPI + SQLAlchemy |
| 存储层 | 持久化与全文检索 | MySQL 8 + Elasticsearch |
| 展示层 | 页面与可视化 | Vue 3 + ECharts + AntV G6 |
| AI 层 | 摘要、人物小传、RAG 问答 | 大模型 API |

完整架构图见 [docs/architecture.md](./docs/architecture.md)，数据模型图见 [docs/er-diagram.md](./docs/er-diagram.md)。

### 关键决策记录（ADR）

| 编号 | 决策 | 理由 | 备选方案 |
|---|---|---|---|
| ADR-001 | 后端采用 Python/FastAPI | 中文 NLP 与图分析生态成熟，与分析层技术栈统一 | Java / Spring Boot |
| ADR-002 | 关系抽取采用共现统计而非依存句法 | 依存句法在古文上准确率低且性能开销大 | 依存句法分析 |
| ADR-003 | 采用 RAG 而非直接问答 | 避免模型幻觉，答案可溯源至原文 | 直接调用大模型 |
| ADR-004 | 仅采集公有领域与开放授权文本 | 规避版权风险，工程合规 | 不限来源 |

## 项目结构

```
.
├── backend/          # FastAPI 服务、分析算法、采集器
│   ├── app/
│   │   ├── api/      # 路由与接口
│   │   ├── service/  # 业务逻辑
│   │   ├── crawler/  # 采集器
│   │   ├── nlp/      # 分词、实体识别、关系抽取
│   │   └── models/   # 数据模型
│   └── tests/
├── frontend/         # Vue 3 前端
│   └── src/
├── docs/             # 架构图、ER 图、ADR
└── .github/          # Issue 模板、PR 模板、CI 配置
```

## 团队与分工

| 成员 | 角色 | 主要职责 | 负责模块 |
|---|---|---|---|
| 许锦芸 | Maintainer / 组长 | 仓库治理、迭代规划、PR 终审、发布 | 数据采集层 |
| 王浩然 | 算法工程师 | 文本分析算法设计与测试 | 文本分析层 |
| 杨凯杰 | 后端工程师 | 数据建模、接口开发、CI/CD | 服务与存储层 |
| 张顺凯 | 前端与 AI 工程师 | 页面、可视化、大模型接入 | 展示与 AI 层 |

## 合规声明

本项目仅采集**公有领域**（作者去世满 50 年）与**明示开放授权**的文本。
采集器强制读取并遵守目标站点 `robots.txt`，请求间隔不低于 1 秒，
不破解任何反爬机制（加密字体、验证码、登录墙）。
每部作品均记录来源 URL 与授权说明，可在作品页查看。

## 贡献指南

见 [CONTRIBUTING.md](./CONTRIBUTING.md)，包含分支规范、Commit 规范、PR 流程与评审要求。

## 许可证

[MIT](./LICENSE)
