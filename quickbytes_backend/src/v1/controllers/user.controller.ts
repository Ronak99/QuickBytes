import httpStatus from "http-status";
import ApiSuccess from "../../utils/ApiSuccess";
import catchAsync from "../../utils/catchAsync";
import { userService } from "../services";

const createUser = catchAsync(async (req, res) => {
  const response = await userService.createUser(req.body);

  res.status(httpStatus.CREATED).send(
    ApiSuccess({
      message: `User Created!`,
      data: response,
    })
  );
});

const queryUser = catchAsync(async (req, res) => {
  // @ts-ignore
  const userId = req.user?.id;

  const response = await userService.queryUser(userId);

  res.status(httpStatus.OK).send(
    ApiSuccess({
      message: `User Details.`,
      data: response,
    })
  );
});

export default {
  queryUser,
  createUser,
};
