# steem-deployments
steemit specific deployment scripts

### Parameters

Some steps can be skipped in `testnetinit.sh` by passing the following environement variables:

* `SKIP_BACKFILL_ACTIONS` - uses actions that contains no backfill
* `SKIP_MAIN_ACCOUNT_CREATION` - uses actions that contain no main (ported) accounts (requires: https://github.com/steemit/tinman/issues/180); automatically implies `SKIP_BACKFILL_ACTIONS`
* `SKIP_SEED_NODE` - disables the public facing seed node and disables init-_n_ witnesses; if skipped, the following nested items are also skipped:
  * `SKIP_WARDEN` - disabled `tinman warden` so that the rest of the deployment can proceed *while* the seed node is syncing.
  * `SKIP_DASHBOARD` -  disables `tinman server`
  * `SKIP_GATLING` - disables `tinman gatling` in the final loop
    * `SKIP_DURABLES` - disables `tinman durables` in `tinman gatling`

**Example:**

```bash
SKIP_BACKFILL_ACTIONS="YES" SKIP_GATLING="YES" testnetinit.sh
```
