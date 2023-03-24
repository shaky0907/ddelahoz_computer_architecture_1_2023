
from tkinter import *
import os
import subprocess
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
def to_list(nombre_archivo):
    with open(nombre_archivo, 'r') as f:
        contenido = f.read()
    lista_numeros = [float(n) for n in contenido.split()]
    return lista_numeros


def fileReader(path):
    file = open(path, 'r')
    data = file.read()
    file.close()
    return data


def main():
    llaves = "1531" + " " + "2747" + " "

    file = open("llaves.txt", "w")
    file.write(llaves)
    file.close()


    os.system('nasm -f elf64 -o RSA.o test.asm')
    os.system('ld -o RSA RSA.o')
    subprocess.call(['./RSA'])

    pathen = './5.txt'

    encryptedPic = to_list(pathen)
    picEn = Image.new('L', (640, 960))
    picEn.putdata(encryptedPic)

    picEn.save("Encrypted.png")
    picEn.close()

    pathde = './decrypt.txt'

    decryptedPic = to_list(pathde)
    picDe = Image.new('L', (640, 480))
    picDe.putdata(decryptedPic)

    picDe.save("Decrypted.png")
    picDe.close()


    window = Tk()
    window.geometry('1600x600')
    window.title('RSA')
    # add widgets here

    frame = Frame(window, width=1600, height=400)
    frame.pack()
    frame.place(anchor='center', relx=0.5, rely=0.5)
    img = ImageTk.PhotoImage(Image.open("Encrypted.png"))


    img2 = ImageTk.PhotoImage(Image.open("Decrypted.png"))

    # Create a Label Widget to display the text or Image
    label = Label(frame, image=img)
    label.pack()

    label2 = Label(frame, image=img2)
    label2.pack()



    window.mainloop()



if __name__ == '__main__':
    main()


