## 背景 / Background

采集、分析、展示三层共用的数据模型尚未落地。需要在 v0.1.0 迭代中确立表结构与约束，避免后续模块各自建表导致字段不一致。

## 需求描述 / Description

基于 `docs/er-diagram.md` 实现全部数据模型与迁移脚本。

## 任务清单 / Tasks

- [ ] 使用 SQLAlchemy 定义 6 张表：`work`、`chapter`、`character`、`relation`、`sentiment`、`qa_record`
- [ ] 配置 Alembic 迁移，生成初始迁移脚本
- [ ] 设置联合唯一约束：`chapter(work_id, chapter_no)`、`character(work_id, name)`、`relation(work_id, char_a, char_b)`
- [ ] 为高频查询字段建立索引：`chapter.work_id`、`character.work_id`、`relation.work_id`
- [ ] 提供 `docker compose` 中的数据库初始化脚本与测试数据种子
- [ ] 补充模型层的单元测试

## 验收标准 / Acceptance Criteria

- [ ] 执行 `alembic upgrade head` 后，数据库中能生成全部 6 张表且字段与 ER 图一致
- [ ] 当插入重复的 `(work_id, chapter_no)` 时，数据库能拒绝插入并抛出完整性错误
- [ ] 当插入重复的作品来源 URL 时，能依靠唯一约束拒绝，避免重复采集
- [ ] 执行 `alembic downgrade base` 后，能完整回滚全部表结构
- [ ] 种子脚本能插入一部含 3 章、5 个人物的测试作品供开发联调
- [ ] 模型中能不包含任何硬编码的数据库口令，口令全部来自环境变量

## 关联 / Related

- 依赖：无
- 阻塞：阻塞 #12、#13、#14

## 元信息

- Assignee: @待补充（杨凯杰）
- Labels: `backend,P0`
- Milestone: `v0.1.0`
