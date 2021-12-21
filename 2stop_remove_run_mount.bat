docker stop python

docker rm python

docker run -dp 8888:8888 ^
-it --mount type=bind,source=%cd%\VOLUMES,target=/home/volumes ^
--name python ^
lee/python ^
jupyter lab --ip=0.0.0.0 --port=8888 --NotebookApp.token='' --allow-root
pause
