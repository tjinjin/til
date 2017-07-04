## mysql

## トランザクション分離レベル
### 確認方法

```
> select @@tx_isolation
```

### 種類
- READ UNCOMMITTED
- READ COMMITTED
- REPEATABLE READ
- SERIALIZABLE


### 変更方法

```
> set session transaction isolation level read committed;
```
