import * as Joi from "joi";

export const RegisterUserSchema1 = Joi.object({
  email: Joi.string()
    .email({ minDomainSegments: 2, tlds: { allow: ["com", "net"] } })
    .required(),
  password: Joi.string().pattern(new RegExp("^[a-zA-Z0-9]{3,30}$")).required(),
  phone: Joi.string().pattern(new RegExp("^[0-9]{1,15}$")).required(),
  codephone: Joi.string().pattern(new RegExp("^[0-9]{1,6}$")).required(),
});

export const LoginSchema = Joi.object({
  email: Joi.string().required(),
  password: Joi.string().required(),
});

export const RefreshTokenSchema = Joi.object({
  refreshToken: Joi.string().required(),
});
