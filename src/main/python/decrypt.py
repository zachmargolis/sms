#
# This is a small script that uses files from the iphone-dataprotection toolkit
# but adds the ability to decrypt just one file (rather than the entire backup)
# https://code.google.com/archive/p/iphone-dataprotection/
#

import os
import plistlib
import sys
import tempfile
import shutil
from backups.backup3 import decrypt_backup3
from backups.backup4 import MBDB
from keystore.keybag import Keybag
from util import readPlist, makedirs
from getpass import getpass

showinfo = ["Device Name", "Display Name", "Last Backup Date", "IMEI",
            "Serial Number", "Product Type", "Product Version", "iTunes Version"]
database = 'Library/SMS/sms.db'
extract_path = 'HomeDomain/'

def extract_sms_db(mbdb, output_path):
    filename, record = mbdb.get_file_by_name(database)

    tmpdir = tempfile.mkdtemp()
    os.makedirs(os.path.join(tmpdir, extract_path, os.path.dirname(database)))
    mbdb.extract_file(filename, record, tmpdir)

    shutil.copyfile(os.path.join(tmpdir, extract_path, database), output_path)
    shutil.rmtree(tmpdir)

def extract_backup(backup_path, output_path, password=""):
    if not os.path.exists(backup_path + "/Manifest.plist"):
        print "Manifest.plist not found"
        return
    manifest = readPlist(backup_path + "/Manifest.plist")

    info = readPlist( backup_path + "/Info.plist")
    for i in showinfo:
        print i + " : " + unicode(info.get(i, "missing"))

    if manifest["IsEncrypted"] and password == "":
        password = getpass('Enter backup password : ')

    if not manifest.has_key("BackupKeyBag"):
        print "oops this is not encrypted"
        exit(1)
    else:
        mbdb = MBDB(backup_path)

        kb = Keybag.createWithBackupManifest(manifest, password)
        if not kb:
            return
        manifest["password"] = password

        mbdb.keybag = kb
        extract_sms_db(mbdb, output_path)

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print "Usage: %s <backup path> [output path]" % sys.argv[0]
        exit(1)

    extract_backup(sys.argv[1], sys.argv[2])