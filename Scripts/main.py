
from tkinter import *
import os
import PIL.Image as Image
from PIL import ImageTk


def toList(data):
    listedData = []
    temp = ''
    for i in data:
        if i != ' ':
            temp += i
        else:
            listedData.append(int(temp))
            temp = ''
    listedData.append(int(temp))
    return listedData

def fileReader(path):
    file = open(path, 'r')
    data = file.read()
    file.close()
    return data


def main():

    os.system('nasm -f elf64 -o RSA.o RSA.asm')
    os.system('ld -o RSA RSA.o')

    os.system('./RSA')

    pathen = '5.txt'
    encryptedPic = fileReader(pathen)
    encryptedPic = toList(encryptedPic)
    picEn = Image.new('L', (320*2, 320))
    picEn.putdata(encryptedPic)

    picEn.save("Encrypted.png")

    window = Tk()
    window.title('RSA')
    # add widgets here

    frame = Frame(window, width=600, height=400)
    frame.pack()
    frame.place(anchor='center', relx=0.5, rely=0.5)
    img = ImageTk.PhotoImage(Image.open("Encrypted.png"))

    # Create a Label Widget to display the text or Image
    label = Label(frame, image=img)
    label.pack()



    window.mainloop()



if __name__ == '__main__':
    main()


