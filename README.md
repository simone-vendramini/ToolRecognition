# Tool Recognition
Applicazione che, data una immagine permetta di riconoscere un set di utensili meccanici posizionati su un piano

Sono state fatte delle assunzioni iniziali relative allo sfondo. In particolare esso deve: 
- Occupare almeno il 50% dell’immagine. 
- Avere un colore il più possibile uniforme. 
- Avere un colore che non sia bianco e/o nero.

Inoltre:
- Gli attrezzi che toccano i bordi non vengono riconosciuti. 
- Gli attrezzi che appartengono a una stessa categoria devono avere una forma simile.

### Come eseguire il codice
- Scaricare cartella script, list e Dataset
- Nella cartella script eseguire il file [Multi Classifier](scripts/multi_classifier.m) per creare un modello
(è già presente un modello pre-trainato chiamato multi_classifier.mat)
- Per eseguire il modello su immagini multiple bisogna far partire [Imaga recognition multi classifier](scripts/image_recognition_multi_classifier.m)


Simone Vendramini,
Tommaso Ferrario,
Francesco Iaia,
Davide Borzì

![alt text](https://github.com/Svendra4UniMiB/ToolsRecognition/blob/main/im_relazione/mokina.png)
