import { User } from "@prisma/client";
import prisma from "../database/client";
class UserService {
  async createUser(user: User) {
    try {
      if (user.codephone && !user.codephone.startsWith("+")) {
        user.codephone = '+' + user.codephone;
      }
      return await prisma.user.create({ data: user });
    } catch (error) {
      console.error("Error al crear usuario:", error);
      throw error; 
    }
  }

  async findUserByEmail(email: string) {
    try {
      return await prisma.user.findFirst({ where: { email } });
    } catch (error) {
      console.error("Error al buscar usuario por email:", error);
      throw error; 
    }
  }
}
export default new UserService();
