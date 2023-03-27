
from tkinter import *
import os
import subprocess
import PIL.Image as Image
from PIL import ImageTk
from tkinter import filedialog as fd



def to_list(nombre_archivo):
    with open(nombre_archivo, 'r') as f:
        contenido = f.read()
    lista_numeros = [float(n) for n in contenido.split()]
    return lista_numeros


def inicio():
    root = Tk()
    root.title('Select file')
    root.resizable(False, False)
    root.geometry('300x150')

    def select_file():
        filetypes = (
            ('text files', '*.txt'),
            ('All files', '*.*')
        )

        filename = fd.askopenfilename(
            title='Open a file',
            initialdir='/home/david/Documents/GitHub/ddelahoz_computer_architecture_1_2023/Scripts',
            filetypes=filetypes)

        print(filename)


        file = open(filename, "r")
        lines = file.read()
        file.close()

        file = open('5.txt', "w")
        file.write(lines)
        file.close()


    # open button
    open_button = Button(
        root,
        text='Open a File',
        command=select_file
    )

    open_button.pack(expand=True)
    root.mainloop()



def main():

    inicio()
    d = input("Inserte el valor de d:")
    n = input("Inserte el valor de n:")
    llaves = " " + d + " " + n + " "


    file = open("llaves.txt", "w")
    file.write(llaves)
    file.close()


    file_object = open('5.txt', 'a')
    #Append 'hello' at the end of file
    file_object.write(' ')
    #Close the file
    file_object.close()

    os.system('nasm -f elf64 -o RSA.o RSA.asm')
    os.system('ld -o RSA RSA.o')
    os.system('gdb RSA')

    window = Tk()
    window.geometry('1600x800')
    window.title('RSA')

    pathen = './5.txt'

    encryptedPic = to_list(pathen)
    picEn = Image.new('L', (640, 960))
    picEn.putdata(encryptedPic)

    picEn.save("Encrypted.png")
    picEn.close()

    image1 = Image.open("Encrypted.png")
    tk_image1 = ImageTk.PhotoImage(image1)
    label1 = Label(window, image=tk_image1)
    label1.grid(row=0, column=0)

    pathde = './decrypt.txt'

    decryptedPic = to_list(pathde)
    picDe = Image.new('L', (640,481))
    picDe.putdata(decryptedPic)

    picDe.save("Decrypted.png")
    picDe.close()
    image2 = Image.open("Decrypted.png")

    tk_image2 = ImageTk.PhotoImage(image2)
    label2 = Label(window, image=tk_image2)
    label2.grid(row=0, column=1)

    window.mainloop()



if __name__ == '__main__':
    main()


