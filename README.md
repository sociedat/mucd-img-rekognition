# Proyecto Babilonia Bélica

Detección y análisis de temáticas en imagenes de redes sociales de agencias de seguridad del estado, su cuantificación y formulación de hipótesis dada esta información.

Las agencias que se examinarán son:

1. Secretaria de Marina
2. Secretaría de la Defensa Nacional
3. Guardia Nacional

## Proceso

1. Se descargan manualmente (debido a las dificultades de la API de FB) imagenes de FB de las páginas de cada una de las agencias, de Enero de 2010 a 2021.
  - i.e. para el análisis de la Secretaría de Marina, este archivo se encuentra en `semar_analysis/data/input/fb-search-csv-export-semar.csv`
2. Cada imagen es etiquetada secuencialmente desde 1
  - En el caso de esta base de datos, tenemos del 1 al 1361
3. Se cargan las imagenes en un bucket en el servicio de storage S3 de AWS (se puede seguir [este tutorial](https://docs.aws.amazon.com/rekognition/latest/dg/getting-started.html)).
3. Se llama a **AWS Rekognition** mediante el script `./call_rekognition.sh`
4. Por cada imagen en el bucket de S3 se generará un JSON como el que sigue, con N etiquetas con su respectiva confianza, y se guardará en `./semar_analysis/data/imgs`:
![](https://i.imgur.com/HXx0yyj.png)
5. Con el script `./from_rekognition_json_to_df.R` leemos y colapsamos cada uno de los JSON resultado de cada img y generamos un DF y lo bajamos al archivo CSV `./semar_analysis/data/output/fb_scores.csv`.
  - De igual forma se generará un DF y un CSV con la sumarización de las etiquetas detectadas en el archivo `./semar_analysis/data/output/fb_summary.csv`
6. Se realiza una labor MANUAL para dividir las etiquetas en `./semar_analysis/data/output/fb_scores.csv` en las siguientes categorías:
  - todas las etiquetas en `./semar_analysis/data/labels/all_labels.txt`
  - etiquetas relacionadas a la labor militar en `./semar_analysis/data/labels/military_labels.txt`
  - etiquetas relacionadas a armamento y equipo táctico en `./semar_analysis/data/labels/weaponry_labels.txt` - esta lista de etiquetas **está contenida** en la lista relacionada con la labor militar
  - etiquetas relacionadas a labores sociales en `./semar_analysis/data/labels/social_labels.txt`
  - etiquetas generales en `./semar_analysis/data/labels/general_labels.txt`
7. Ejecutar el notebook `./semar_analysis/notebook_fb_analysis.Rmd` y publicarlo.

