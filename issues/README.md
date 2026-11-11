# Issue 索引

共 20 个 Issue，人均 5 个。正文见 `issues/issue-XX.md`，可逐条复制粘贴到 GitHub，或用 `create_issues.sh` 批量创建。

| Issue | 标题 | 负责人 | Labels | Milestone | 正文文件 |
|---|---|---|---|---|---|
| #1 | 实现 robots 校验与请求限速器 | 许锦芸 | `crawler,P0` | v0.1.0 | [issue-01.md](./issue-01.md) |
| #2 | 实现正文抽取与清洗管道 | 许锦芸 | `crawler,P0` | v0.1.0 | [issue-02.md](./issue-02.md) |
| #3 | 实现多源站点采集器 | 许锦芸 | `crawler,P0` | v0.1.0 | [issue-03.md](./issue-03.md) |
| #4 | 实现增量抓取与 URL 去重 | 许锦芸 | `crawler,P0` | v0.1.0 | [issue-04.md](./issue-04.md) |
| #5 | 实现章回标题识别与章节切分 | 许锦芸 | `parser,P1` | v0.1.0 | [issue-05.md](./issue-05.md) |
| #6 | 接入分词与词性标注服务 | 王浩然 | `nlp,P0` | v0.1.0 | [issue-06.md](./issue-06.md) |
| #7 | 实现人物实体识别与频次统计 | 王浩然 | `nlp,P0` | v0.1.0 | [issue-07.md](./issue-07.md) |
| #8 | 实现别名词典与归一处理 | 王浩然 | `nlp,P0` | v0.1.0 | [issue-08.md](./issue-08.md) |
| #9 | 实现人物共现关系抽取算法 | 王浩然 | `nlp,P0` | v0.1.0 | [issue-09.md](./issue-09.md) |
| #10 | 实现章节情感值计算 | 王浩然 | `nlp,P1` | v0.2.0 | [issue-10.md](./issue-10.md) |
| #11 | 设计数据库模型与迁移脚本 | 杨凯杰 | `backend,P0` | v0.1.0 | [issue-11.md](./issue-11.md) |
| #12 | 实现作品与章节 REST 接口 | 杨凯杰 | `backend,P0` | v0.1.0 | [issue-12.md](./issue-12.md) |
| #13 | 实现图谱数据查询与缓存接口 | 杨凯杰 | `backend,P0` | v0.2.0 | [issue-13.md](./issue-13.md) |
| #14 | 接入 Elasticsearch 全文检索 | 杨凯杰 | `backend,P1` | v0.2.0 | [issue-14.md](./issue-14.md) |
| #15 | 配置 GitHub Actions 与测试门禁 | 杨凯杰 | `ci,P0` | v0.1.0 | [issue-15.md](./issue-15.md) |
| #16 | 实现人物关系图谱可视化页面 | 张顺凯 | `frontend,P0` | v0.2.0 | [issue-16.md](./issue-16.md) |
| #17 | 实现人物详情与出场曲线页面 | 张顺凯 | `frontend,P0` | v0.2.0 | [issue-17.md](./issue-17.md) |
| #18 | 接入大模型实现摘要与人物小传 | 张顺凯 | `ai,P1` | v0.2.0 | [issue-18.md](./issue-18.md) |
| #19 | 实现 RAG 问答与溯源展示 | 张顺凯 | `ai,P1` | v0.2.0 | [issue-19.md](./issue-19.md) |
| #20 | 实现情感曲线可视化页面 | 张顺凯 | `frontend,P1` | v0.2.0 | [issue-20.md](./issue-20.md) |

## 分布统计

| 成员 | 数量 | Issue |
|---|---|---|
| 许锦芸 | 5 | #1—#5 |
| 王浩然 | 5 | #6—#10 |
| 杨凯杰 | 5 | #11—#15 |
| 张顺凯 | 5 | #16—#20 |

| 里程碑 | 数量 | Issue |
|---|---|---|
| v0.1.0 | 12 | #1—#9、#11—#12、#15 |
| v0.2.0 | 8 | #10、#13—#14、#16—#20 |