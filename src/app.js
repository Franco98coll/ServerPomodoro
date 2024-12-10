import express from 'express';
import cors from 'cors';

const app = express();

app.use(express.json());

const allowedOrigins = [
    'https://tomatempo.netlify.app',
    'http://localhost:3000',
    'http://app:3000'
];

app.use(cors({
    origin: function (origin, callback) {
        // Permite solicitudes sin origen (como las de herramientas de desarrollo)
        if (!origin) return callback(null, true);
        if (allowedOrigins.indexOf(origin) === -1) {
            const msg = 'El CORS policy no permite el acceso desde el origen especificado.';
            return callback(new Error(msg), false);
        }
        return callback(null, true);
    },
    methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
    allowedHeaders: ['Content-Type', 'Authorization'],
    credentials: true
}));

// Maneja las solicitudes preflight (OPTIONS)
app.options('*', cors());

export default app;
