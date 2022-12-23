# Práctica Final RDSV

### Arranque de las máquinas del escenario en K8s

Con este fichero se automatiza el arranque de las máquinas en K8s:

```
chmod 777 initScenario.sh
./initScenario.sh
```

Con este fichero se automatiza la destrucción de las máquinas en K8s:

```
chmod 777 stopScenario.sh
./stopScenario.sh
```

### Creación de la carpeta rdsv-final con los paquetes helm

Con este fichero se automatiza la creación de la carpeta rdsv-final para la ejecución de esta práctica.

```
chmod 777 initFolder.sh
./initFolder.sh
```

### Creación del servicio renes

Con este fichero se automatizan los apartados 3, 4, 5, 7 y 9 de la práctica 4. Se crea el servicio renes1.

```
chmod 777 runRenes.sh
./runRenes.sh
```

### Definición de pods

Con este fichero se automatiza la obtención de las variables de entorno asociadas a los KNF.

```
chmod 777 handlePods.sh
./handlePods.sh
```
