# Vasp Tools 

[![Build Status](https://drone-ci-kramergroup.serveo.net/api/badges/kramergroup-workflows/vasp-tools/status.svg)](https://drone-ci-kramergroup.serveo.net/kramergroup-workflows/vasp-tools)

This repository bundles a number of VASP related tools 

## Create VASP relax calculation from CIF

```bash
vasp-tools create-from-cif
```

This creates a VASP relax run using sensible defaults from the [materialsproject.org](http://www.materialsproject.org).

### Configuration

The container expects a CIF file in `/data/structure.cif` containing the structure. The location of the cif file can be 
configured via environment variables. 

The generated VASP input files are written to `/data/vasp`.

#### Environment variables

| Name         | Default               | Description                                   |
| ------------ | --------------------- | --------------------------------------------- |
| `CIF_FILE`   | `/data/structure.cif` | The full path of the structure CIF file       |
| `VASP_FILES` | `/data/vasp`          | The location for writing the VASP input files |

### Overwriting Vasp Parameters

The container parses `stdin` for a JSON data-structure to overwrite `INCAR` defaults. For instance:

```json
{
  "ENCUT": "600",
  "EDIFFG": "-1e-4"
}
```

could be used to set a custom energy cut-off and convergence criterium.
