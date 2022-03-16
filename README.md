# Workflow demo

This repository demonstrates my general set up to conducting data-driven research. As a git repository, the set up includes 3 main elements:

* A ``.gitignore`` file. You will notice that the gitignore ignores the entire data directory so that large data files do not sync to GitHub. In order to save my data, I usually store the entire directory in a place that syncs to Google Drive or Dropbox. I also ignore auxiliary files like jupyter notebook checkpoints, Rhistory, and auxilary tex files.
* A ``README.md`` file . The more detailed the README, the better. In some of my projects, the readme has a table with each code file and what it does. Here, I describe the order that the repository should be examined in.
* The rest of the code and writing.

I organize the following explanation of workflow and files in this repository in order of (ex-post) organization of research activities:

1. **Data cleaning:** ``code/cleaning/data-cleaning.ipynb``. Data is stored in the ``data/raw`` directory, and data stored here should never be modified from its original form. 
	* Usually I need to play around with the data, make some plots, and otherwise explore before settling into data cleaning and analysis, so I put any files related to these activities in ``code/exploratory``. I like to do this part in jupyter notebooks, especially given that these can be downloaded as html files so that you can easily show others the plots you find interesting.
	* Then, for real data cleaning, I usually work in ``.py`` files stored in ``code/cleaning``. These files import data from ``data/raw``, and export them in clean csv format to ``data/out``.

2. **Data analysis and Econometrics:** ``code/metrics/main-metrics-analysis.R``. Next I create output for the paper (regressions, summary tables, figures, etc.). For the moment, my language of choice for this is R. My workflow at this stage is:
	1. import the clean data from ``data/out``.
	2. Create tables and export them _without a float environment_ to a ``.tex`` file stored in ``tex/tabs``
	3. Create figures and export them as a ``.pdf`` in ``tex/figs``

3. **Writing:** ``tex/viewers/viewer.tex, viewer.pdf``. Finally, analysis must be written up in a paper (hopeully!) for publication. All the writing materials are stored in the ``tex`` directory.
	* ``tex/viewers`` holds "viewer" files that I use to check out regression tables and figures along the way; this is a scratch-type directory, and can also git ignored.
	* ``tex/paper`` holds the paper itself, which is a similar tex file as the viewer and imports tables and figures in the same way. 
	* I would also store the ``.bib`` file in the ``tex/paper`` directory.
	* Other directories are helpful for presentations and proposals that are also made in latex.

Most of the above directories are empty, but I created them to give a sense of the overall file structure.

4. ``tools/metrics-env.yml``. The ``tools`` directory holds technical files such as the ``.yml`` file that describes the conda environment that I did the work in which is helpful for replication.



