# 贡献指南

本仓库遵循课程考核方案中的工程规范，所有成员在开始开发前请完整阅读本文档。

## 一、分支策略

`main` 分支**受保护，禁止直接推送**。所有变更必须经 Pull Request 合并。

分支命名格式：

| 类型 | 格式 | 示例 |
|---|---|---|
| 新功能 | `feature/<issue号>-<简述>` | `feature/7-character-ner` |
| 缺陷修复 | `bugfix/<issue号>-<简述>` | `bugfix/21-login-error` |
| 紧急修复 | `hotfix/<issue号>-<简述>` | `hotfix/30-security-fix` |
| 文档 / 构建 | `chore/<简述>` | `chore/update-ci` |

标准开发流程：

```bash
# 1. 永远从最新的 main 切出新分支
git switch main
git pull origin main
git switch -c feature/7-character-ner

# 2. 开发后提交（粒度：一个逻辑变更一次提交）
git add backend/app/nlp/ner.py
git commit -m "feat: implement character entity recognition"
git add backend/tests/test_ner.py
git commit -m "test: add unit tests for character NER"

# 3. 推送并发起 PR
git push -u origin feature/7-character-ner

# 4. 合并后清理
git switch main
git pull origin main
git branch -d feature/7-character-ner
```

## 二、Commit Message 规范

遵循 Conventional Commits，类型限定为：
`feat` `fix` `docs` `test` `refactor` `style` `chore` `perf`

| 判定 | 示例 |
|---|---|
| ✅ 合格 | `feat: implement character co-occurrence extraction` |
| ✅ 合格 | `fix: prevent empty keyword from triggering search` |
| ✅ 合格 | `test: add integration test for graph API` |
| ❌ 不合格 | `update` |
| ❌ 不合格 | `修改` |
| ❌ 不合格 | `final / final2 / 真的最终版` |
| ❌ 不合格 | `fix bug` |

## 三、Pull Request 流程

1. PR 描述必须包含 `Closes #<issue号>`，实现 Issue 与代码的双向可追溯。
2. 单个 PR 变更规模控制在 **400 行以内**；超过 800 行须说明理由并拆分。
3. 每个 PR 至少 **1 名非作者成员 Approve**，且至少 1 条实质性评审意见。
4. **禁止自评自合**（自己 Approve 自己的 PR 后立刻合并）。
5. CI 状态检查全部通过后才能合并。

### 高质量 Code Review 意见要求

评审意见应涉及正确性、可读性、健壮性、安全、测试、命名等具体技术维度，
而非 "LGTM" 式敷衍。示例：

> `nlp/ner.py:48` 中 `alias_map` 未做并发保护，采集任务多线程写入时可能产生竞态。
> 建议改为在处理前统一加载、处理后批量写回，或改用 `threading.Lock`。

## 四、Issue 规范

每个 Issue 必须包含：

- 背景 / Background
- 需求描述 / Description
- 任务清单 / Tasks（可勾选）
- **验收标准 / Acceptance Criteria**（可验证陈述，用「能……」而非「做好……」）
- 负责人 / Assignee（不允许无主 Issue 直接进入开发）
- 标签 / Labels
- 里程碑 / Milestone

任务粒度：单个 Issue 预计工作量控制在 **2~8 小时**；超大任务须拆分，超小任务须合并。

## 五、测试要求

- 核心模块（Service 层 / API 层）测试覆盖率**不低于 40%**。
- 测试断言必须有实际校验内容，覆盖正常、边界、异常三类。
- 禁止 `assert True` 式空断言，不计入覆盖率得分。

```bash
cd backend
pytest --cov=app --cov-report=term --cov-report=html
```

## 六、安全规范

- 不得将密钥、数据库口令、Token 提交入库。
- 使用 `.env` 配置敏感信息，`.env` 已写入 `.gitignore`。
- 仓库仅保留 `.env.example`，其中只包含键名与占位值。

## 七、标签说明

| 标签 | 含义 |
|---|---|
| `crawler` / `nlp` / `backend` / `frontend` / `ai` / `ci` | 所属模块 |
| `P0` / `P1` / `P2` | 优先级 |
| `bug` / `enhancement` / `documentation` | 类型 |
| `good first issue` | 适合新人上手的简单任务 |
