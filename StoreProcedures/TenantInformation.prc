/****** Object:  StoredProcedure [dbo].[sp_TenantInformation]    Script Date: 28/02/2018 10:44:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Author, , Sudheer Reddy>
-- Create Date: <15-02-2018, , >
-- Description: <BI Build the stored procedure for tenant information belong to the property >
-- =============================================
ALTER PROCEDURE [dbo].[sp_TenantInformation] @pid NVARCHAR(50)
AS
     SET NOCOUNT ON;
     SELECT tp.TenantId,
            p.ProfilePhoto,
            p.FirstName+' '+p.LastName Name,
            t.HomePhoneNumber,
            t.MobilePhoneNumber,
            t.CreatedBy,
            tp.PaymentStartDate,
            tp.StartDate StartDate,
            tp.enddate EndDate,
            tp.PaymentAmount PaymentAmount,
            l.email Email,
            CASE PaymentFrequencyId
                WHEN '1'
                THEN 'Weekly'
                WHEN '2'
                THEN 'FortNight'
                ELSE 'Monthly'
            END PaymentFrequency,
            a.Number+' '+a.Street+' '+a.Suburb+' '+a.City
     FROM Tenant t
          JOIN TenantProperty tp ON t.Id = tp.TenantId
          JOIN Person p ON t.Id = p.id
          JOIN Login l ON l.id = tp.TenantId
          JOIN property pp ON tp.PropertyId = pp.id
          JOIN Address a ON a.AddressId = pp.AddressId
     WHERE tp.IsActive = 1
           AND tp.PropertyId = @pid;
