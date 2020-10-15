#!/usr/bin/env python3
"""
Given the path to a boostnote storage folder, extracts all notes from cson files
and writes them into a new file in markdown format in the output folder.
Each markdown file is named YYYYMMDD_lower_case_title and a folder with same basename
is created to contain all attachments referenced in the note.
cmdoret, 20200215
"""
import cson
import sys
import re
import os
import pathlib
import shutil as st

boost_dir = pathlib.Path(sys.argv[1])
out_dir = pathlib.Path(sys.argv[2])
os.makedirs(str(out_dir), exist_ok=True)
print(f"Extracting notes and attachments in {boost_dir} into {out_dir}...")

# Iterate over cson notes
for cson_path in boost_dir.glob('notes/*cson'):
    # Read note into a dictionary
    with open(cson_path, 'r') as note_handle:
        note = cson.load(note_handle)
        # Skip note if empty
        if 'content' not in note.keys():
            continue
        # Get date into iso format
        iso_date = note['createdAt'][:10].replace('-', '')
        # Only keep alphanumeric characters and underscores
        # from the lowercase title
        clean_title = re.sub('[^0-9a-z_]', '', note['title'].lower())
        out_md = out_dir / f"{iso_date}_{clean_title}.md"
        in_attach = boost_dir / 'attachments' / str(cson_path.name).strip('.cson')
        out_attach = out_dir / f"{iso_date}_{clean_title}"
        print(f"{cson_path.name} -> {out_md.name}")
        # Write metadata as markdown-formatted header, followed by content
        # with updated attachment paths.
        with open(out_md, 'w') as md_handle:
            md_handle.write(
                '\n'.join(
                    [
                        f"# {note['title']}",
                        f"**{note['createdAt']}**\n",
                        f"> tags: {note['tags']}\n",
                        re.sub(':storage/[^/]*', str(out_attach), note['content'])
                    ]
                )
            )
        # Copy attachments if there are any in the note
        try:
            st.copytree(in_attach, out_attach)
        except FileNotFoundError:
            pass

