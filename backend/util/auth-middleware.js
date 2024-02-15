
import jwt  from "jsonwebtoken";

export default function authMiddleware(request, response, next) {

    if (!request.headers.authorization) {
        // const error = new Error('Unauthorized for missing authentication');
        // error.status = 401;
        // Will be passed to error handler function
        return next({ status: 401, message: 'Unauthorized for missing authentication' });
    }

    // Get token from authorization headers
    const authToken = request.headers.authorization.split(' ')[1];
    if (!authToken) return next({ status: 401, message: 'Unauthorized for missing authentication' });

    // Verify Token
    try {
        const verifiedToken = jwt.verify(authToken, DUMMY_SECRET);
        request.token = verifiedToken;
    } catch (err) {
        return next({ status: 403, message: 'Invalid token' });
    }

    next();
}


// In real projects this 
// needs to be from process.env.DUMMY_SECRET
// Always hide secrets and keys in .env
export const DUMMY_SECRET = 'DUMMY_SECRET';