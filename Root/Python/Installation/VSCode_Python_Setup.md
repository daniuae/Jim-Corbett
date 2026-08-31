# VS Code Python Setup Guide

## NumPy + Pandas on macOS, Ubuntu, and Windows

This guide is for a first-time VS Code Python setup.

The goal is to create a clean, repeatable environment for:

-   Python
-   NumPy
-   Pandas
-   Matplotlib
-   Seaborn
-   Jupyter Notebook

The same basic workflow works on macOS, Ubuntu, and Windows.

------------------------------------------------------------------------

# 1. The Setup You Are Building

``` text
VS Code
   |
   v
Python Interpreter
   |
   v
Virtual Environment (.venv)
   |
   +---- NumPy
   |
   +---- Pandas
   |
   +---- Matplotlib
   |
   +---- Seaborn
   |
   +---- Jupyter
```

## Golden Rule

> One project -\> one `.venv` -\> install packages inside that `.venv`.

Do not install project packages globally unless you have a specific
reason.

------------------------------------------------------------------------

# 2. Install VS Code

Download and install Visual Studio Code for your operating system.

After installation, open VS Code.

Useful shortcuts:

  Action            macOS                           Windows / Ubuntu
  ----------------- ------------------------------- --------------------
  Command Palette   `Cmd + Shift + P`               `Ctrl + Shift + P`
  Extensions        `Cmd + Shift + X`               `Ctrl + Shift + X`
  Terminal          ``` Cmd + `` | ```Ctrl + \`\`   

------------------------------------------------------------------------

# 3. Install Python

VS Code does not install Python automatically. Install a Python
interpreter separately.

## macOS

Open Terminal:

``` bash
python3 --version
```

If Python is installed, you should see something similar to:

``` text
Python 3.x.x
```

If Python is not installed, install Python from the official Python
distribution and then verify:

``` bash
python3 --version
```

Also check:

``` bash
python3 -m pip --version
```

### Important macOS note

On many Mac systems, the Python command is:

``` bash
python3
```

rather than:

``` bash
python
```

So this may fail:

``` bash
python -m venv .venv
```

Use this instead:

``` bash
python3 -m venv .venv
```

------------------------------------------------------------------------

## Ubuntu

Open Terminal:

``` bash
python3 --version
```

If Python or the virtual-environment package is missing:

``` bash
sudo apt update
sudo apt install python3 python3-venv python3-pip
```

Verify:

``` bash
python3 --version
```

and:

``` bash
python3 -m pip --version
```

------------------------------------------------------------------------

## Windows

Open PowerShell:

``` powershell
python --version
```

If that does not work, try:

``` powershell
py --version
```

During Python installation, enable:

``` text
Add Python to PATH
```

Then restart VS Code and verify again.

------------------------------------------------------------------------

# 4. Install VS Code Extensions

Open:

``` text
Extensions
```

Install these extensions.

## Required

### Python

Publisher:

``` text
Microsoft
```

The Python extension provides Python execution, IntelliSense, debugging,
environment selection, and other Python development features.

## Recommended

Install:

``` text
Pylance
Jupyter
Python Debugger
```

### Why Jupyter?

Pandas and NumPy are especially convenient to learn interactively using
`.ipynb` notebooks.

------------------------------------------------------------------------

# 5. Create Your First Project

Create a folder:

``` text
pandas_numpy_project
```

Recommended structure:

``` text
pandas_numpy_project/
|
+-- .venv/
|
+-- notebooks/
|   +-- pandas_numpy_basics.ipynb
|
+-- src/
|   +-- practice.py
|
+-- data/
|   +-- sample.csv
|
+-- requirements.txt
|
+-- .gitignore
|
+-- README.md
```

Do not manually create `.venv`. It will be created by Python.

------------------------------------------------------------------------

# 6. Open the Project in VS Code

In VS Code:

``` text
File
  |
  +-- Open Folder
        |
        +-- pandas_numpy_project
```

Or from a terminal:

``` bash
cd pandas_numpy_project
code .
```

If `code` is not recognized, open the folder from the VS Code menu
instead.

------------------------------------------------------------------------

# 7. Create the Virtual Environment

A virtual environment keeps project dependencies isolated.

Python's built-in `venv` module is the standard way to create one.

## macOS

``` bash
python3 -m venv .venv
```

## Ubuntu

``` bash
python3 -m venv .venv
```

## Windows

``` powershell
python -m venv .venv
```

After this, you should have:

``` text
pandas_numpy_project/
|
+-- .venv/
```

------------------------------------------------------------------------

# 8. Activate the Virtual Environment

This is the main operating-system difference.

## macOS

``` bash
source .venv/bin/activate
```

## Ubuntu

``` bash
source .venv/bin/activate
```

## Windows PowerShell

``` powershell
.venv\Scripts\Activate.ps1
```

## Windows Command Prompt

``` cmd
.venv\Scripts\activate.bat
```

After activation, your terminal should show:

``` text
(.venv)
```

For example:

``` text
(.venv) username@MacBook pandas_numpy_project %
```

or:

``` text
(.venv) PS C:\Users\User\pandas_numpy_project>
```

------------------------------------------------------------------------

# 9. Windows PowerShell Activation Problem

If you receive an error similar to:

``` text
running scripts is disabled on this system
```

Open PowerShell and run:

``` powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

Then activate again:

``` powershell
.venv\Scripts\Activate.ps1
```

------------------------------------------------------------------------

# 10. Upgrade pip

Once `.venv` is active:

``` bash
python -m pip install --upgrade pip
```

Using:

``` bash
python -m pip
```

helps ensure that pip belongs to the Python environment you are
currently using.

------------------------------------------------------------------------

# 11. Install NumPy and Pandas

Install the core packages:

``` bash
python -m pip install numpy pandas
```

For a complete beginner data-analysis environment, install:

``` bash
python -m pip install numpy pandas matplotlib seaborn jupyter
```

You now have:

  Package      Purpose
  ------------ --------------------------------
  NumPy        Numerical computing
  Pandas       Data manipulation and analysis
  Matplotlib   Visualization
  Seaborn      Statistical visualization
  Jupyter      Interactive notebooks

------------------------------------------------------------------------

# 12. Verify NumPy and Pandas

Run:

``` bash
python
```

Then:

``` python
import numpy as np
import pandas as pd

print("NumPy:", np.__version__)
print("Pandas:", pd.__version__)
```

You should see the installed versions.

Exit Python:

``` python
exit()
```

Or press:

``` text
Ctrl + D
```

on macOS/Linux.

On Windows, you can also use:

``` text
Ctrl + Z
Enter
```

------------------------------------------------------------------------

# 13. Select the Correct Python Interpreter in VS Code

This is one of the most important steps.

Open the Command Palette:

``` text
Cmd + Shift + P
```

on macOS.

Or:

``` text
Ctrl + Shift + P
```

on Windows/Ubuntu.

Search:

``` text
Python: Select Interpreter
```

Choose the interpreter inside your project:

``` text
.venv
```

It may appear similar to:

``` text
Python 3.x.x ('.venv': venv)
```

The selected environment is used for Python execution, debugging,
IntelliSense, and related features.

------------------------------------------------------------------------

# 14. Check the Interpreter

Create:

``` text
src/practice.py
```

Add:

``` python
import sys

print(sys.executable)
```

Run:

``` bash
python src/practice.py
```

The output should point to your project's `.venv`.

For example, on macOS/Linux:

``` text
.../pandas_numpy_project/.venv/bin/python
```

On Windows:

``` text
...\pandas_numpy_project\.venv\Scripts\python.exe
```

If you see `.venv`, you are using the correct environment.

------------------------------------------------------------------------

# 15. Your First NumPy Program

Create:

``` text
src/numpy_basics.py
```

Add:

``` python
import numpy as np

numbers = np.array([10, 20, 30, 40, 50])

print(numbers)
print("Mean:", numbers.mean())
print("Maximum:", numbers.max())
print("Minimum:", numbers.min())
```

Run:

``` bash
python src/numpy_basics.py
```

------------------------------------------------------------------------

# 16. Your First Pandas Program

Create:

``` text
src/pandas_basics.py
```

Add:

``` python
import pandas as pd

data = {
    "Name": ["John", "David", "Mary"],
    "Salary": [50000, 60000, 70000]
}

df = pd.DataFrame(data)

print(df)
print()
print("Average salary:", df["Salary"].mean())
```

Run:

``` bash
python src/pandas_basics.py
```

------------------------------------------------------------------------

# 17. Create a Jupyter Notebook

Create:

``` text
notebooks/pandas_numpy_basics.ipynb
```

VS Code should open the notebook editor.

Create the first cell:

``` python
import numpy as np
import pandas as pd
```

Run the cell.

Create another cell:

``` python
arr = np.array([10, 20, 30, 40, 50])

arr
```

Create another:

``` python
df = pd.DataFrame({
    "Name": ["John", "David", "Mary"],
    "Salary": [50000, 60000, 70000]
})

df
```

------------------------------------------------------------------------

# 18. Select the Jupyter Kernel

If VS Code asks:

``` text
Select Kernel
```

choose the Python environment from:

``` text
.venv
```

For example:

``` text
Python 3.x.x ('.venv')
```

If `.venv` does not appear:

1.  Open Command Palette.
2.  Run `Python: Select Interpreter`.
3.  Select `.venv`.
4.  Reopen the notebook.
5.  Select the `.venv` kernel.

------------------------------------------------------------------------

# 19. Create requirements.txt

Create:

``` text
requirements.txt
```

Add:

``` text
numpy
pandas
matplotlib
seaborn
jupyter
```

Another machine can then install the same project dependencies with:

``` bash
python -m pip install -r requirements.txt
```

This is particularly useful when moving the project between:

-   macOS
-   Ubuntu
-   Windows
-   trainee machines
-   GitHub repositories

------------------------------------------------------------------------

# 20. Freeze Exact Package Versions

After your environment is working, you can record the exact installed
versions:

``` bash
python -m pip freeze > requirements.txt
```

The file may then contain entries similar to:

``` text
numpy==...
pandas==...
matplotlib==...
seaborn==...
jupyter==...
```

This gives you a reproducible environment.

For a training course, decide whether you want:

``` text
requirements.txt
```

with broad package names, or a fully frozen requirements file with exact
versions.

------------------------------------------------------------------------

# 21. Create .gitignore

If you use GitHub, create:

``` text
.gitignore
```

Add:

``` text
.venv/
__pycache__/
*.pyc
.ipynb_checkpoints/
.DS_Store
```

Do NOT upload:

``` text
.venv/
```

The virtual environment is machine-specific and should be recreated on
each computer.

------------------------------------------------------------------------

# 22. Recommended Final Project Structure

``` text
pandas_numpy_project/
|
+-- .venv/                         # Local virtual environment
|
+-- notebooks/
|   +-- pandas_numpy_basics.ipynb
|
+-- src/
|   +-- numpy_basics.py
|   +-- pandas_basics.py
|   +-- practice.py
|
+-- data/
|   +-- sample.csv
|
+-- requirements.txt
+-- .gitignore
+-- README.md
```

------------------------------------------------------------------------

# 23. Daily Workflow

Every time you start working on the project:

## Step 1

Open VS Code.

## Step 2

Open:

``` text
pandas_numpy_project
```

## Step 3

Check the Python interpreter.

It should be:

``` text
.venv
```

## Step 4

Open a new terminal.

VS Code can automatically activate the selected environment.

You should see:

``` text
(.venv)
```

## Step 5

Run your Python program:

``` bash
python src/practice.py
```

Or open your Jupyter notebook:

``` text
notebooks/pandas_numpy_basics.ipynb
```

------------------------------------------------------------------------

# 24. When You See "ModuleNotFoundError"

Example:

``` text
ModuleNotFoundError: No module named 'pandas'
```

First check:

``` bash
python -c "import pandas; print(pandas.__version__)"
```

If that fails, check the active environment:

``` bash
python -c "import sys; print(sys.executable)"
```

If `.venv` is not shown, activate/select the correct environment.

Then install:

``` bash
python -m pip install pandas
```

For NumPy:

``` bash
python -m pip install numpy
```

------------------------------------------------------------------------

# 25. When .venv Does Not Appear in VS Code

Run:

``` text
Python: Select Interpreter
```

If it is not listed:

1.  Make sure `.venv` exists.
2.  Close and reopen VS Code.
3.  Run:

``` text
Python Environments: Refresh All Environment Managers
```

4.  Run:

``` text
Python: Select Interpreter
```

5.  Select `.venv`.

Current VS Code Python tooling automatically searches workspace-local
`.venv` environments by default.

------------------------------------------------------------------------

# 26. When VS Code Runs the Wrong Python

Check:

``` bash
python -c "import sys; print(sys.executable)"
```

The output should contain:

``` text
pandas_numpy_project/.venv/
```

If it does not:

``` text
Cmd/Ctrl + Shift + P
```

then:

``` text
Python: Select Interpreter
```

Select:

``` text
.venv
```

Then open a new terminal.

------------------------------------------------------------------------

# 27. When `python` Is Not Found

## macOS / Ubuntu

Try:

``` bash
python3 --version
```

If Python is available as `python3`, create the environment with:

``` bash
python3 -m venv .venv
```

After activating `.venv`:

``` bash
source .venv/bin/activate
```

you should normally be able to use:

``` bash
python
```

## Windows

Try:

``` powershell
python --version
```

or:

``` powershell
py --version
```

If neither works, install/reinstall Python and ensure it is available on
PATH.

------------------------------------------------------------------------

# 28. When `pip` Is Not Found

Do not immediately worry about the `pip` command.

Use:

``` bash
python -m pip --version
```

Then:

``` bash
python -m pip install pandas
```

This is the preferred pattern for this course.

------------------------------------------------------------------------

# 29. When Jupyter Cannot Find Pandas

First verify:

``` bash
python -c "import pandas; print(pandas.__version__)"
```

If Pandas works in the terminal but not in the notebook, the notebook is
probably using a different kernel.

In the notebook:

``` text
Select Kernel
      |
      v
.venv
```

Then rerun:

``` python
import pandas as pd
```

------------------------------------------------------------------------

# 30. When a Notebook Shows "Kernel Died"

Check the selected kernel.

Then test:

``` bash
python -c "import numpy; import pandas; print('OK')"
```

If that works, restart the notebook kernel and select `.venv` again.

If the environment is badly damaged, it is often faster to recreate it.

------------------------------------------------------------------------

# 31. Recreating a Broken Environment

Deactivate the environment:

``` bash
deactivate
```

Delete `.venv`.

Then create it again.

## macOS / Ubuntu

``` bash
python3 -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
```

## Windows

``` powershell
python -m venv .venv
.venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
```

This is one of the biggest advantages of using a virtual environment
plus `requirements.txt`.

------------------------------------------------------------------------

# 32. Useful Verification Commands

## Python version

``` bash
python --version
```

## Python location

``` bash
python -c "import sys; print(sys.executable)"
```

## pip location

``` bash
python -m pip --version
```

## Installed packages

``` bash
python -m pip list
```

## NumPy version

``` bash
python -c "import numpy; print(numpy.__version__)"
```

## Pandas version

``` bash
python -c "import pandas; print(pandas.__version__)"
```

## Test everything

``` bash
python -c "import numpy, pandas, matplotlib, seaborn; print('All packages OK')"
```

------------------------------------------------------------------------

# 33. Operating System Cheat Sheet

  ------------------------------------------------------------------------------------------------------------
  Task              macOS                         Ubuntu                        Windows
  ----------------- ----------------------------- ----------------------------- ------------------------------
  Python            `python3`                     `python3`                     `python`

  Create venv       `python3 -m venv .venv`       `python3 -m venv .venv`       `python -m venv .venv`

  Activate          `source .venv/bin/activate`   `source .venv/bin/activate`   `.venv\Scripts\Activate.ps1`

  Deactivate        `deactivate`                  `deactivate`                  `deactivate`

  Install package   `python -m pip install X`     same                          same

  Run program       `python file.py`              `python file.py`              `python file.py`

  Python version    `python3 --version`           `python3 --version`           `python --version`
  ------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------

# 34. Recommended Teaching Standard

For a Pandas + NumPy training program, standardize every trainee machine
on:

``` text
VS Code
+
Python 3
+
Python Extension
+
Pylance
+
Jupyter
+
Project-specific .venv
+
NumPy
+
Pandas
+
Matplotlib
+
Seaborn
```

Every trainee should learn this workflow:

``` text
CREATE PROJECT
      |
      v
OPEN PROJECT IN VS CODE
      |
      v
CREATE .venv
      |
      v
SELECT .venv
      |
      v
INSTALL PACKAGES
      |
      v
VERIFY INSTALLATION
      |
      v
CREATE .py FILE
      |
      v
CREATE .ipynb FILE
      |
      v
START LEARNING
```

------------------------------------------------------------------------

# 35. The Five Commands Trainees Must Remember

If a trainee remembers only five commands, teach these:

### 1. Create environment

``` bash
python3 -m venv .venv
```

Use `python -m venv .venv` on Windows.

### 2. Activate

``` bash
source .venv/bin/activate
```

Use `.venv\Scripts\Activate.ps1` on Windows PowerShell.

### 3. Install packages

``` bash
python -m pip install numpy pandas
```

### 4. Run Python

``` bash
python
```

### 5. Run a program

``` bash
python practice.py
```

------------------------------------------------------------------------

# 36. Final Verification Checklist

Before starting the Pandas/NumPy course, verify:

-   [ ] VS Code installed
-   [ ] Python installed
-   [ ] Python extension installed
-   [ ] Pylance installed
-   [ ] Jupyter installed
-   [ ] Project folder created
-   [ ] `.venv` created
-   [ ] `.venv` activated
-   [ ] `.venv` selected in VS Code
-   [ ] pip upgraded
-   [ ] NumPy installed
-   [ ] Pandas installed
-   [ ] Matplotlib installed
-   [ ] Seaborn installed
-   [ ] Jupyter kernel points to `.venv`
-   [ ] `requirements.txt` created
-   [ ] `.gitignore` created
-   [ ] NumPy test successful
-   [ ] Pandas test successful

------------------------------------------------------------------------

# 37. Success Test

Run this final program:

``` python
import numpy as np
import pandas as pd

print("Python environment: OK")
print("NumPy:", np.__version__)
print("Pandas:", pd.__version__)

numbers = np.array([10, 20, 30, 40, 50])

df = pd.DataFrame({
    "Name": ["A", "B", "C"],
    "Score": [85, 90, 95]
})

print("\nNumPy Array:")
print(numbers)

print("\nPandas DataFrame:")
print(df)

print("\nEnvironment setup completed successfully!")
```

If this runs successfully, your VS Code Python environment is ready for
the Pandas + NumPy course.

------------------------------------------------------------------------

# References

-   Visual Studio Code --- Python:
    https://code.visualstudio.com/docs/languages/python
-   Visual Studio Code --- Python environments:
    https://code.visualstudio.com/docs/python/environments
-   Visual Studio Code --- Python tutorial:
    https://code.visualstudio.com/docs/python/python-tutorial
-   Python documentation --- Virtual environments:
    https://docs.python.org/3/tutorial/venv.html
