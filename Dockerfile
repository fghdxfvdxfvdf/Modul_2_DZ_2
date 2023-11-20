# Використовуємо базовий образ Python
FROM python:3.12

# Встановлюємо poetry
# RUN curl -sSL https://install.python-poetry.org | python -
# RUN export PATH=$PATH:/root/.poetry/bin

# Встановимо змінну середовища
ENV APP_HOME /app

# Встановимо робочу директорію всередині контейнера
WORKDIR $APP_HOME

# Встановимо залежності всередині контейнера
COPY pyproject.toml $APP_HOME/pyproject.toml
COPY poetry.lock $APP_HOME/poetry.lock
RUN pip install poetry
RUN poetry config virtualenvs.create false && poetry install --only main

# Скопіюємо інші файли в робочу директорію контейнера
COPY . .
# # Встановлюємо залежності проекту
# WORKDIR /app
# COPY pyproject.toml poetry.lock /app/
# RUN poetry install --no-root

# # Додаємо інші файли проекту
# COPY . /app/

# Запускаємо додаток
CMD ["poetry", "run", "python", "__main__.py"]
