FROM openjdk:8
MAINTAINER pranshujain

ENV SPARK_VERSION 3.3.1
ENV SPARK_HOME /opt/spark-$SPARK_VERSION/spark-3.3.1-bin-hadoop3
ENV PATH $SPARK_HOME/bin:$PATH

RUN	mkdir -p /opt/spark-$SPARK_VERSION && \
    	wget -O spark https://downloads.apache.org/spark/spark-3.3.1/spark-3.3.1-bin-hadoop3.tgz && \
	tar -xzf spark -C $SPARK_HOME

ENV PATH /root/miniconda3/bin:$PATH
ENV PYSPARK_DRIVER_PYTHON jupyter
ENV PYSPARK_DRIVER_PYTHON_OPTS 'notebook'

RUN 	wget -O Miniconda.sh https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
	chmod a+x Miniconda.sh && \
	./Miniconda.sh -b && \
	rm Miniconda.sh && \
	python3 -m pip install jupyter && \
	pip install ipyparallel && \
	ipcluster nbextension enable

# ADD spark/ $SPARK_HOME/
# ADD Miniconda.sh .

# RUN	chmod a+x Miniconda.sh && \
# 	./Miniconda.sh -b && \
# 	rm Miniconda.sh && \
# 	python3 -m pip install jupyter && \
# 	pip install ipyparallel && \
# 	ipcluster nbextension enable

ENV PYTHONPATH $SPARK_HOME/python/:$SPARK_HOME/python/lib/py4j-0.10.7-src.zip:$SPARK_HOME/python/lib/pyspark.zip:$PYTHONPATH

EXPOSE 8888

CMD jupyter notebook --allow-root --no-browser --ip='*' --NotebookApp.token='' --NotebookApp.password='' --port=8888
