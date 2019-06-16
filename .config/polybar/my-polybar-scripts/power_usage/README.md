# Script: power-usage

A script that shows the current battery power usage in mW.

## Configuration

You must have tlp-stat installed. No further configuration needed.

## Module

```ini
[module/power_usage]
type = custom/script
exec = ~/my-polybar-scripts/power_usage/power_usage.sh
interval = 2
```
