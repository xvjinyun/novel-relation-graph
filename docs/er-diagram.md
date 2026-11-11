# 数据模型

## ER 图

```mermaid
erDiagram
    WORK ||--o{ CHAPTER : contains
    WORK ||--o{ CHARACTER : has
    WORK ||--o{ RELATION : has
    CHAPTER ||--o| SENTIMENT : has
    CHARACTER ||--o{ RELATION : participates
    WORK ||--o{ QA_RECORD : records

    WORK {
        int id PK
        string title
        string author
        string source_url
        string license_note
    }
    CHAPTER {
        int id PK
        int work_id FK
        int chapter_no
        string title
        text content
    }
    CHARACTER {
        int id PK
        int work_id FK
        string name
        json alias_list
        int mention_count
    }
    RELATION {
        int id PK
        int work_id FK
        int char_a FK
        int char_b FK
        int weight
    }
    SENTIMENT {
        int id PK
        int chapter_id FK
        float score
    }
    QA_RECORD {
        int id PK
        int work_id FK
        string question
        text answer
        json evidence_ref
    }
```

## 实体说明

| 实体 | 说明 | 关键约束 |
|---|---|---|
| Work | 作品元信息与授权说明 | source_url 唯一，避免重复采集 |
| Chapter | 章节正文与序号 | (work_id, chapter_no) 联合唯一 |
| Character | 人物实体及别名字典 | (work_id, name) 联合唯一 |
| Relation | 人物共现关系及权重 | (work_id, char_a, char_b) 联合唯一 |
| Sentiment | 章节情感值序列 | 每章节一条 |
| QaRecord | 问答记录与溯源引用 | evidence_ref 记录章节定位 |
