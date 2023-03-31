FROM node:19-alpine
COPY app/app.js /app/
COPY app/package.json /app/
WORKDIR /app/
EXPOSE 3000
RUN npm install
CMD ["node", "app.js"]


