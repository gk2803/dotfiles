#!/bin/bash
echo "activating virtual environment"
source /home/rqd3/sources/qmk_firmware/venv/bin/activate
cd /home/rqd3/sources/qmk_firmware/
echo "compiling keymap"
qmk compile -kb crkbd/rev4_1/standard -km gk2803
echo "compilation finished"
echo "deactivating  virtual environment"
deactivate
