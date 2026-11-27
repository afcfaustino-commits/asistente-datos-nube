# Receta del contenedor de la app «Asistente de Datos y Nube»

# Imagen base: Python 3.11 en versión liviana (slim)
FROM python:3.11-slim

# Sin archivos .pyc y con mensajes inmediatos en los registros de Render
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Carpeta de trabajo dentro del contenedor
WORKDIR /app

# Primero las dependencias: si no cambian, Docker reutiliza esta capa
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Después, el código de la app
COPY . .

# Usuario sin privilegios de administrador (buena práctica de seguridad)
RUN useradd --create-home appuser
USER appuser

# Puerto por defecto; Render lo reemplaza con la variable PORT
EXPOSE 7860
CMD ["python", "app.py"]
