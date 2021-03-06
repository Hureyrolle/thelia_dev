<?php
/*************************************************************************************/
/*      This file is part of the Thelia package.                                     */
/*                                                                                   */
/*      Copyright (c) OpenStudio                                                     */
/*      email : dev@thelia.net                                                       */
/*      web : http://www.thelia.net                                                  */
/*                                                                                   */
/*      For the full copyright and license information, please view the LICENSE.txt  */
/*      file that was distributed with this source code.                             */
/*************************************************************************************/

namespace Thelia\Command;

use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Thelia\Core\Event\Module\ModuleToggleActivationEvent;
use Thelia\Core\Event\TheliaEvents;
use Thelia\Model\ModuleQuery;
use Thelia\Module\BaseModule;

/**
 * Deactivates a module
 *
 * Class ModuleDeactivateCommand
 * @package Thelia\Command
 * @author Nicolas Villa <nicolas@libre-shop.com>
 *
 */
class ModuleDeactivateCommand extends BaseModuleGenerate
{
    protected function configure()
    {
        $this
            ->setName("module:deactivate")
            ->setDescription("Deactivate a module")
            ->addArgument(
                "module",
                InputArgument::REQUIRED,
                "module to deactivate"
            )
        ;
    }

    protected function execute(InputInterface $input, OutputInterface $output)
    {
        $moduleCode = $this->formatModuleName($input->getArgument("module"));

        $module = ModuleQuery::create()->findOneByCode($moduleCode);

        if (null === $module) {
            throw new \RuntimeException(sprintf("module %s not found", $moduleCode));
        }

        if ($module->getActivate() == BaseModule::IS_NOT_ACTIVATED) {
            throw new \RuntimeException(sprintf("module %s is already deactivated", $moduleCode));
        }


        try {
            $event = new ModuleToggleActivationEvent($module->getId());
            $this->getDispatcher()->dispatch(TheliaEvents::MODULE_TOGGLE_ACTIVATION, $event);
        } catch (\Exception $e) {
            throw new \RuntimeException(sprintf("Deactivation fail with Exception : [%d] %s", $e->getCode(), $e->getMessage()));
        }

        //impossible to change output class in CommandTester...
        if (method_exists($output, "renderBlock")) {
            $output->renderBlock(array(
                '',
                sprintf("Deactivation succeed for module %s", $moduleCode),
                ''
            ), "bg=green;fg=black");
        }
    }
}
