## 背景 / Background

本项目明确承诺仅采集公有领域与开放授权文本，并遵守目标站点的 robots.txt。当前采集器尚未有任何合规校验与限速机制，直接抓取既违反项目自身的合规声明，也存在封禁 IP 的风险。

## 需求描述 / Description

在采集层实现统一的 robots.txt 校验组件与可配置限速器，作为所有出站请求的强制前置关卡。

## 任务清单 / Tasks

- [ ] 实现 `RobotsChecker` 类，加载并解析目标站点 robots.txt，缓存解析结果（TTL 可配置，默认 24 小时）
- [ ] 实现 `RateLimiter` 类，按域名维度控制请求间隔，默认不低于 1 秒，间隔可通过环境变量 `CRAWLER_DELAY_SECONDS` 配置
- [ ] 在采集器的出站请求链路中强制接入上述两个组件，无法绕过
- [ ] 实现自定义 User-Agent，默认值为 `novel-graph-bot/0.1`，可通过环境变量覆盖
- [ ] 补充单元测试与集成测试

## 验收标准 / Acceptance Criteria

- [ ] 当请求目标路径被 robots.txt 的 `Disallow` 规则覆盖时，能拒绝抓取并在日志中记录被拒原因，且不发出实际 HTTP 请求
- [ ] 当 robots.txt 不存在或不可达时，能按默认放行策略处理并在日志中记录告警
- [ ] 当 `CRAWLER_DELAY_SECONDS` 设为 1 时，连续 5 次请求同一域名的实测总耗时能不少于 4 秒
- [ ] 当请求不同域名时，能各自独立计时而不互相阻塞
- [ ] 当并发采集任务同时发起请求时，限速器能正常工作且不产生竞态异常
- [ ] 单元测试覆盖率不低于 60%，`pytest` 全部通过

## 关联 / Related

- 依赖：无
- 阻塞：阻塞 #3 多源站点采集器

## 元信息

- Assignee: @xvjinyun
- Labels: `crawler,P0`
- Milestone: `v0.1.0`
