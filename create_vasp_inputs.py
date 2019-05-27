#!/usr/bin/env python

import os
ciffile = os.environ['CIF_FILE']
vaspfiles = os.environ['VASP_FILES']

import pymatgen as mg
from pymatgen.io.vasp.sets import MPRelaxSet

# Read the structure
structure = mg.Structure.from_file(ciffile)

custom_settings = {}

relax = MPRelaxSet(structure, user_incar_settings=custom_settings)
relax.write_input(vaspfiles)
