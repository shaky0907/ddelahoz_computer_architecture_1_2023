
from tkinter import *
import os
import subprocess
import PIL.Image as Image
from PIL import ImageTk



def to_list(nombre_archivo):
    with open(nombre_archivo, 'r') as f:
        contenido = f.read()
    lista_numeros = [float(n) for n in contenido.split()]
    return lista_numeros


def main():
    llaves = " 1531" + " " + "2747" + " "

    file = open("llaves.txt", "w")
    file.write(llaves)
    file.close()


    #file_object = open('5.txt', 'a')
    # Append 'hello' at the end of file
    #file_object.write(' ')
    # Close the file
    #file_object.close()


    os.system('nasm -f elf64 -o RSA.o RSA.asm')
    os.system('ld -o RSA RSA.o')
    os.system('gdb RSA')




    pathen = './5.txt'

    encryptedPic = to_list(pathen)
    picEn = Image.new('L', (640, 960))
    picEn.putdata(encryptedPic)

    picEn.save("Encrypted.png")
    picEn.close()

    pathde = './decrypt.txt'

    decryptedPic = to_list(pathde)
    picDe = Image.new('L', (640, 481))
    picDe.putdata(decryptedPic)

    picDe.save("Decrypted.png")
    picDe.close()


    window = Tk()
    window.geometry('1600x800')
    window.title('RSA')
    # add widgets here

    image1 = Image.open("Encrypted.png")
    image2 = Image.open("Decrypted.png")

    # Convierte las imágenes a formato Tkinter
    tk_image1 = ImageTk.PhotoImage(image1)
    tk_image2 = ImageTk.PhotoImage(image2)

    # Crea dos etiquetas para mostrar las imágenes
    label1 = Label(window, image=tk_image1)
    label1.grid(row=0, column=0)

    label2 = Label(window, image=tk_image2)
    label2.grid(row=0, column=1)



    window.mainloop()



if __name__ == '__main__':
    main()


