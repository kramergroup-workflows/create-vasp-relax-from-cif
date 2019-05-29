#!/usr/bin/env python

import os
import json
import sys
import select

ciffile = os.environ['CIF_FILE']
vaspfiles = os.environ['VASP_FILES']

import pymatgen as mg
from pymatgen.io.vasp.sets import MPRelaxSet

# Read the structure
structure = mg.Structure.from_file(ciffile)

try:
  custom_settings = json.load(sys.stdin)
except:
  print("Warning: Could not process custom settings from stdin.")
  custom_settings = {}


relax = MPRelaxSet(structure, user_incar_settings=custom_settings)
relax.write_input(vaspfiles)
