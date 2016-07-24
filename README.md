# sms

These are the scripts I use to extract my iPhone text message database backups

They're not particularly portable yet, but I wanted to share what I had

## Usage

### `copy_backups`

The `copy_backups` script copies all the messages databases across all the backups
on the machine, and decrypts them as needed (the script will prompt for the password for each encrypted backup)

### `combine`

Use `combine` to extract messages from the SQLite databases into a CSV.

## Requirements

- The [iphone-dataprotection][iphone-dataprotection] source for dealing with encrypted backups

[iphone-dataprotection]: https://code.google.com/archive/p/iphone-dataprotection/