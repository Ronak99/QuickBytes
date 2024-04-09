import express from "express";
import httpStatus from "http-status";
import config from "./config/config";
import routes from "./v1/routes";
import ApiError from "./utils/ApiError";
import passport from "passport";
import { jwtStrategy } from "./config/passport";
import { errorHandler } from "./middlewares/error";

const app = express();

// enable cors
// app.use(cors());
// app.options("*", cors());

// parse json request body
app.use(express.json());

// parse urlencoded request body
app.use(express.urlencoded({ extended: true }));

// v1 api routes
app.use("/v1", routes);

// send back a 404 error for any unknown api request
app.use((req: any, res: any, next: any) => {
  next(new ApiError(httpStatus.NOT_FOUND, "Not found"));
});

// jwt authentication
app.use(passport.initialize());
passport.use("jwt", jwtStrategy);

// convert error to ApiError, if needed
// app.use(errorConverter);

// handle error
// launch from CLI -> heroku addons:open airbrake
// app.use(airbrakeExpress.makeErrorHandler(airbrake));
app.use(errorHandler);

export default app;
