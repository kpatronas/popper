# popper
Navigate between directories the easiest possible way!

# What popper does?
Allows you to push a directories in list and then navigate back to a pushed directory by selecting the directory from a menu.

# Preparations

Copy the file in /bin

```
chmod +x ./popper.sh
sudo cp ./popper.sh /bin/popper.sh
```

Create an alias to your ~/.bashrc (required)

The way that the script works needs to be called within the same bash shell and not to create a new one, to do this we use an alias and the source command
```
alias popper='source /bin/popper.sh'
```
# How to use

Navigate to a directory and enter
```
popper -u
```
Navigate to another directory and enter again
```
popper -u
```

Now to list the pushed directories
```
popper -l
/home/kpatronas/work
/home/kpatronas
```

To go to the one of the pushed directories
```
popper -o
1) /home/kpatronas/work
2) /home/kpatronas
#?
```
Enter the number of the directory and press enter, now you should be in the selected directory

to delete an entry from the pushed directories
```
popper -d
1) /home/kpatronas/work
2) /home/kpatronas
#? 2
popper -l
/home/kpatronas/work
```

You can also go to a directory and delete the entry at the same time
```
popper -d -o
1) /home/kpatronas/work
2) /home/kpatronas
#? 2
popper -l
/home/kpatronas/work
```

To delete all entries
```
popper -f
```

# Where is the list of the entries?
```
$HOME/.popper/popper.csv
```
