## 背景 / Background

团队四人并行开发，缺少自动化构建与测试门禁会导致缺陷在合并后才暴露，也无法满足考核方案对 CI 作为合并强制门禁的要求。

## 需求描述 / Description

配置 GitHub Actions 流水线，并将其设为 PR 合并的强制状态检查。

## 任务清单 / Tasks

- [ ] 编写 `.github/workflows/ci.yml`，包含安装依赖、Lint、测试、构建四步
- [ ] 配置后端 job：Python 3.11 + ruff + pytest + 覆盖率校验（低于 40% 失败）
- [ ] 配置前端 job：Node 20 + lint + build
- [ ] 在分支保护规则中将上述两个 job 设为 Required status checks
- [ ] 配置 PR 与 push 到 main 时均触发流水线
- [ ] 验证流水线能真实失败：故意引入一个失败测试，确认 CI 红灯并阻止合并

## 验收标准 / Acceptance Criteria

- [ ] 向任意分支推送代码后，CI 能自动触发并在 5 分钟内给出结果
- [ ] 当测试全部通过时，CI 状态为绿灯，PR 允许合并
- [ ] 当存在失败测试时，CI 状态为红灯，且 PR 因状态检查未通过而被阻止合并
- [ ] 当后端覆盖率低于 40% 时，CI 能失败并在日志中输出实际覆盖率数值
- [ ] 当代码存在 Lint 错误时，CI 能失败并指出具体文件与行号
- [ ] 流水线配置文件已入库于 `.github/workflows/`，可被仓库记录追溯

## 关联 / Related

- 依赖：无
- 阻塞：无

## 元信息

- Assignee: @待补充（杨凯杰）
- Labels: `ci,P0`
- Milestone: `v0.1.0`
