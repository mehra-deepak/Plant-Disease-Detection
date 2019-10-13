import os

folders = os.listdir()

for i in folders:
    if i == 'test.py':
        pass
    elif i == '1' or i == '0':
        pass
    else:
        folder_path = os.path.join(os.getcwd(), i)
        file_names = os.listdir(folder_path)
        name = 1
        for file in file_names:
            # path = os.path.join(folder_path,file)
            os.rename(os.path.join(folder_path,file),os.path.join(folder_path, str(name) + '.jpg'))
            print(type(name))
            name = name + 1
    