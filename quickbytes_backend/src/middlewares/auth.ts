import passport from "passport";
import httpStatus from "http-status";
import ApiError from "../utils/ApiError";
import { NextFunction, Request, Response } from "express";
import { user } from "@prisma/client";

const verifyCallback =
  (
    req: any,
    resolve: (value?: unknown) => void,
    reject: (reason?: unknown) => void
  ) =>
  async (err: unknown, user: any | false, info: unknown) => {
    console.log("err - ", err);
    console.log("user - ", user);
    console.log("info - ", info);
    if (err || info || !user) {
      return reject(
        new ApiError(httpStatus.UNAUTHORIZED, "Please authenticate!")
      );
    }
    req.user = user;

    // if (requiredRights.length) {
    //   const userRights = roleRights.get(user.role) ?? [];
    //   const hasRequiredRights = requiredRights.every((requiredRight) =>
    //     userRights.includes(requiredRight)
    //   );
    //   if (!hasRequiredRights && req.params.userId !== user.id) {
    //     return reject(new ApiError(httpStatus.FORBIDDEN, 'Forbidden'));
    //   }
    // }

    return resolve();
  };

const auth = () => async (req: Request, res: Response, next: NextFunction) => {
  // console.log("req = ", req.cookies, req.signedCookies);
  return new Promise((resolve, reject) => {
    passport.authenticate(
      "jwt",
      { session: false },
      verifyCallback(req, resolve, reject)
    )(req, res, next);
  })
    .then(() => next())
    .catch((err) => next(err));
};

export default auth;
