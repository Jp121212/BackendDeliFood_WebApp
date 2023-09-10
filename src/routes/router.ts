import { Application } from "express";
import authRouter from "./auth";

export default function router(app: Application): void {
  /**
   * Every source are specifed here
   */
  app.get("/health", (_req, res) => res.sendStatus(200));
  app.use("/auth", authRouter);
}
